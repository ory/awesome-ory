package me.hauke.quarkuskratos.auth

import jakarta.annotation.Priority
import jakarta.inject.Inject
import jakarta.ws.rs.NameBinding
import jakarta.ws.rs.NotAuthorizedException
import jakarta.ws.rs.Priorities
import jakarta.ws.rs.WebApplicationException
import jakarta.ws.rs.container.ContainerRequestContext
import jakarta.ws.rs.container.ContainerRequestFilter
import jakarta.ws.rs.core.Cookie
import jakarta.ws.rs.core.Response
import jakarta.ws.rs.ext.ExceptionMapper
import jakarta.ws.rs.ext.Provider
import org.eclipse.microprofile.rest.client.inject.RestClient
import org.jboss.logging.Logger
import java.net.URI

@Secured
@Provider
@Priority(Priorities.AUTHENTICATION)
class AuthenticationFilter : ContainerRequestFilter {
    @Inject
    @RestClient
    lateinit var kratosClient: KratosClient

    companion object {
        private val LOG = Logger.getLogger(AuthenticationFilter::class.java)
    }

    override fun filter(context: ContainerRequestContext) {
        val cookie: Cookie? = context.cookies["ory_kratos_session"]

        if (cookie == null) {
            LOG.warn("No cookie found")
            throw NotAuthorizedException("please login")
        }

        // The cookie value is the session token, so it is never logged.
        LOG.info("Mmmmmh, cookie found")

        val response = try {
            kratosClient.getWhoAmI(cookie.value)
        } catch (e: WebApplicationException) {
            LOG.warn(e)
            throw NotAuthorizedException("please login")
        }

        LOG.debug(response)
    }
}

@NameBinding
@kotlin.annotation.Retention(AnnotationRetention.RUNTIME)
@Target(AnnotationTarget.CLASS, AnnotationTarget.FUNCTION)
annotation class Secured

@Provider
class PermissionExceptionHandler : ExceptionMapper<NotAuthorizedException> {
    override fun toResponse(e: NotAuthorizedException?): Response {
        return Response.temporaryRedirect(URI("/")).build()
    }
}
