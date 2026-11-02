package me.hauke.quarkuskratos.auth

import io.quarkus.qute.Location
import io.quarkus.qute.Template
import io.quarkus.qute.TemplateInstance
import jakarta.inject.Inject
import jakarta.ws.rs.GET
import jakarta.ws.rs.Path
import jakarta.ws.rs.Produces
import jakarta.ws.rs.QueryParam
import jakarta.ws.rs.WebApplicationException
import jakarta.ws.rs.core.MediaType
import org.eclipse.microprofile.rest.client.inject.RestClient

@Path("/error")
class ErrorEndpoint @Inject constructor(
        @RestClient val kratosClient: KratosClient,
        @Location("auth/error.html") val errorTemplate: Template
) {
    // Kratos sends the browser here when a flow fails in a way the flow can't
    // show itself, with the id of the error it stored. An error that has
    // expired, or a Kratos that can't be reached, still gets a page.
    @GET
    @Produces(MediaType.TEXT_HTML)
    fun error(@QueryParam("id") id: String?): TemplateInstance {
        val error = id?.let {
            try {
                kratosClient.getFlowError(it).error
            } catch (e: WebApplicationException) {
                null
            }
        }

        return errorTemplate.data(
                "message", error?.message ?: "Something went wrong.",
                "reason", error?.reason ?: ""
        )
    }
}
