package me.hauke.quarkuskratos.auth

import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import org.eclipse.microprofile.rest.client.inject.RegisterRestClient
import javax.ws.rs.*
import javax.ws.rs.core.Cookie

@RegisterRestClient(configKey = "kratos")
interface KratosClient {
    @GET
    @Path("/self-service/registration/flows")
    fun getRegistrationFlow(@QueryParam("id") flowId: String): KratosResponse

    @GET
    @Path("/self-service/login/flows")
    fun getLoginFlow(@QueryParam("id") flowId: String): KratosResponse

    @GET
    @Path("/sessions/whoami")
    @Throws(WebApplicationException::class)
    fun getWhoAmI(@CookieParam("ory_kratos_session") kratosSession: Cookie): String

    @JsonIgnoreProperties(ignoreUnknown = true)
    data class KratosResponse(
            val id: String,
            val type: String,
            val messages: List<KratosMessage>?,
            val methods: Map<String, KratosMethod>
    ) {

        data class KratosMethod(
                val method: String,
                val config: KratosMethodConfig
        )

        data class KratosMethodConfig(
                val action: String,
                val method: String,
                val fields: List<KratosField>
        )

        data class KratosField(
                val name: String,
                val type: String,
                val required: Boolean = false,
                val value: String?,
                val messages: List<KratosMessage>?
        )

        data class KratosMessage(
                // val context: String,
                val id: String,
                val text: String,
                val type: String
        )
    }
}
