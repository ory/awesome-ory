package me.hauke.quarkuskratos.auth

import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import com.fasterxml.jackson.annotation.JsonProperty
import jakarta.ws.rs.*
import org.eclipse.microprofile.rest.client.inject.RegisterRestClient

@RegisterRestClient(configKey = "kratos")
interface KratosClient {
    // The flows are fetched server-side, so the browser's cookies have to be
    // passed on: Kratos checks the flow's CSRF cookie and answers 403 without it.
    @GET
    @Path("/self-service/registration/flows")
    fun getRegistrationFlow(
        @QueryParam("id") flowId: String,
        @HeaderParam("Cookie") cookie: String?
    ): KratosFlow

    @GET
    @Path("/self-service/login/flows")
    fun getLoginFlow(
        @QueryParam("id") flowId: String,
        @HeaderParam("Cookie") cookie: String?
    ): KratosFlow

    @GET
    @Path("/sessions/whoami")
    @Throws(WebApplicationException::class)
    fun getWhoAmI(@CookieParam("ory_kratos_session") kratosSession: String): String

    @GET
    @Path("/self-service/errors")
    fun getFlowError(@QueryParam("id") errorId: String): KratosFlowError

    @GET
    @Path("/self-service/logout/browser")
    @Throws(WebApplicationException::class)
    fun createLogoutFlow(@HeaderParam("Cookie") cookie: String?): KratosLogoutFlow

    @JsonIgnoreProperties(ignoreUnknown = true)
    data class KratosFlow(
        val id: String,
        val type: String,
        val ui: KratosUi
    ) {
        // Everything the form needs is in `ui`: where to post it, and one node
        // per input, button or message. Older Kratos versions grouped the fields
        // by method under `methods` instead.
        @JsonIgnoreProperties(ignoreUnknown = true)
        data class KratosUi(
            val action: String,
            val method: String,
            val nodes: List<KratosNode> = emptyList(),
            val messages: List<KratosMessage>? = null
        )

        @JsonIgnoreProperties(ignoreUnknown = true)
        data class KratosNode(
            val type: String,
            val group: String,
            val attributes: KratosNodeAttributes,
            val messages: List<KratosMessage> = emptyList(),
            val meta: KratosNodeMeta? = null
        )

        @JsonIgnoreProperties(ignoreUnknown = true)
        data class KratosNodeAttributes(
            val name: String? = null,
            val type: String? = null,
            val value: Any? = null,
            val required: Boolean = false,
            @JsonProperty("node_type") val nodeType: String? = null
        )

        @JsonIgnoreProperties(ignoreUnknown = true)
        data class KratosNodeMeta(
            val label: KratosMessage? = null
        )

        @JsonIgnoreProperties(ignoreUnknown = true)
        data class KratosMessage(
            val id: Long,
            val text: String,
            val type: String
        )
    }

    @JsonIgnoreProperties(ignoreUnknown = true)
    data class KratosFlowError(
        val id: String,
        val error: KratosError? = null
    ) {
        @JsonIgnoreProperties(ignoreUnknown = true)
        data class KratosError(
            val code: Int? = null,
            val status: String? = null,
            val reason: String? = null,
            val message: String? = null
        )
    }

    @JsonIgnoreProperties(ignoreUnknown = true)
    data class KratosLogoutFlow(
        @JsonProperty("logout_url") val logoutUrl: String
    )
}
