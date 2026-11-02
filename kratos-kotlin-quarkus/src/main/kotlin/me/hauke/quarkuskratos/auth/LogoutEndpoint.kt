package me.hauke.quarkuskratos.auth

import jakarta.inject.Inject
import jakarta.ws.rs.HeaderParam
import jakarta.ws.rs.POST
import jakarta.ws.rs.Path
import jakarta.ws.rs.WebApplicationException
import jakarta.ws.rs.core.Response
import org.eclipse.microprofile.rest.client.inject.RestClient
import java.net.URI

@Path("/auth/logout")
class LogoutEndpoint @Inject constructor(
        @RestClient val kratosClient: KratosClient
) {
    // Kratos hands out a logout URL that belongs to the current session. The
    // browser follows it, Kratos revokes the session and sends the browser back
    // to the app. Without a session there is nothing to log out of.
    //
    // This is a POST from a form, not a link: a GET would let any other site
    // log the user out with a top-level link, since the session cookie is sent
    // along with those.
    @POST
    fun logout(@HeaderParam("Cookie") cookie: String?): Response {
        val logoutUrl = try {
            kratosClient.createLogoutFlow(cookie).logoutUrl
        } catch (e: WebApplicationException) {
            if (e.response.status >= 500) throw e
            return Response.seeOther(URI("/")).build()
        }

        return Response.seeOther(URI(logoutUrl)).build()
    }
}
