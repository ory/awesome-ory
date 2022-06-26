package me.hauke.quarkuskratos.auth

import io.vertx.core.http.HttpServerRequest
import org.eclipse.microprofile.rest.client.inject.RestClient
import org.jboss.logging.Logger
import java.net.URI
import javax.annotation.Priority
import javax.inject.Inject
import javax.inject.Provider as InjectProvider
import javax.ws.rs.NameBinding
import javax.ws.rs.NotAuthorizedException
import javax.ws.rs.Priorities
import javax.ws.rs.WebApplicationException
import javax.ws.rs.container.ContainerRequestContext
import javax.ws.rs.container.ContainerRequestFilter
import javax.ws.rs.core.Context
import javax.ws.rs.core.Cookie
import javax.ws.rs.core.Response
import javax.ws.rs.ext.ExceptionMapper
import javax.ws.rs.ext.Provider

@Secured
@Provider
@Priority(Priorities.AUTHENTICATION)
class AuthenticationFilter : ContainerRequestFilter {
    @Context
    lateinit var request: HttpServerRequest

    @Inject
    @RestClient
    lateinit var kratosClient: InjectProvider<KratosClient>

    companion object {
        private val LOG = Logger.getLogger(AuthenticationFilter::class.java)
    }

    override fun filter(context: ContainerRequestContext) {
        val cookie: Cookie? = context.cookies["ory_kratos_session"]

        if (cookie == null) {
            LOG.warn("No cookie found")
            throw NotAuthorizedException("please login")
        }

        LOG.info("Mmmmmh, Cookie: $cookie")

        val response = try {
            kratosClient.get().getWhoAmI(cookie)
        } catch (e: WebApplicationException) {
            LOG.warn(e)
            throw NotAuthorizedException("please login")
        }

        LOG.info(response)
    }
}

@NameBinding
@kotlin.annotation.Retention(AnnotationRetention.RUNTIME)
@Target(AnnotationTarget.CLASS, AnnotationTarget.FUNCTION)
annotation class Secured

@Provider
class PermissionExceptionHandler : ExceptionMapper<NotAuthorizedException> {
    override fun toResponse(e: NotAuthorizedException?): Response {
        return Response.temporaryRedirect(URI("http://127.0.0.1:8080/")).build()
    }
}
