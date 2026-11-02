package me.hauke.quarkuskratos.auth

import io.quarkus.qute.TemplateInstance
import jakarta.inject.Inject
import jakarta.ws.rs.GET
import jakarta.ws.rs.HeaderParam
import jakarta.ws.rs.Path
import jakarta.ws.rs.Produces
import jakarta.ws.rs.QueryParam
import jakarta.ws.rs.core.MediaType

@Path("/auth/login")
class LoginEndpoint @Inject constructor(
        val loginService: LoginService
) {
    @GET
    @Produces(MediaType.TEXT_HTML)
    fun login(
            @QueryParam("flow") flow: String?,
            @HeaderParam("Cookie") cookie: String?): TemplateInstance =
            loginService.login(flow, cookie)
}
