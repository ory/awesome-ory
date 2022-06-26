import io.quarkus.qute.TemplateInstance
import me.hauke.quarkuskratos.auth.RegistrationService
import javax.inject.Inject
import javax.ws.rs.GET
import javax.ws.rs.Path
import javax.ws.rs.Produces
import javax.ws.rs.QueryParam
import javax.ws.rs.core.MediaType

@Path("/auth/registration")
class RegistrationEndpoint @Inject constructor(
        val registrationService: RegistrationService
) {
    @GET
    @Produces(MediaType.TEXT_HTML)
    fun registration(
            @QueryParam("flow") flow: String): TemplateInstance =
            registrationService.registration(flow)
}