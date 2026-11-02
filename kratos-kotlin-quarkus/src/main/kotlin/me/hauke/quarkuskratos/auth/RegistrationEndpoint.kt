package me.hauke.quarkuskratos.auth

import io.quarkus.qute.TemplateInstance
import jakarta.inject.Inject
import jakarta.ws.rs.GET
import jakarta.ws.rs.HeaderParam
import jakarta.ws.rs.Path
import jakarta.ws.rs.Produces
import jakarta.ws.rs.QueryParam
import jakarta.ws.rs.core.MediaType

@Path("/auth/registration")
class RegistrationEndpoint @Inject constructor(
        val registrationService: RegistrationService
) {
    @GET
    @Produces(MediaType.TEXT_HTML)
    fun registration(
            @QueryParam("flow") flow: String?,
            @HeaderParam("Cookie") cookie: String?): TemplateInstance =
            registrationService.registration(flow, cookie)
}
