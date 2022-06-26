package me.hauke.quarkuskratos.auth

import io.quarkus.qute.TemplateInstance
import javax.inject.Inject
import javax.ws.rs.GET
import javax.ws.rs.Path
import javax.ws.rs.Produces
import javax.ws.rs.QueryParam
import javax.ws.rs.core.MediaType

@Path("/auth/login")
class LoginEndpoint @Inject constructor(
        val loginService: LoginService
) {
    @GET
    @Produces(MediaType.TEXT_HTML)
    fun login(@QueryParam("flow") flow: String): TemplateInstance =
            loginService.login(flow)
}
