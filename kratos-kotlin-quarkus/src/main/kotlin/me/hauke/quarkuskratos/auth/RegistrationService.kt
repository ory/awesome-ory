package me.hauke.quarkuskratos.auth

import io.quarkus.qute.Location
import io.quarkus.qute.Template
import io.quarkus.qute.TemplateInstance
import jakarta.enterprise.context.ApplicationScoped
import jakarta.inject.Inject
import org.eclipse.microprofile.config.inject.ConfigProperty
import org.eclipse.microprofile.rest.client.inject.RestClient

@ApplicationScoped
class RegistrationService @Inject constructor(
    @RestClient val kratosClient: KratosClient,
    @Location("auth/registration.html") val registrationTemplate: Template,
    @ConfigProperty(name = "kratos.browser-url") val kratosBrowserUrl: String,
) {
    // Kratos registers in two steps by default: the traits first, then the
    // password. Both steps come back to this page with the same flow id, and the
    // nodes tell the template which step to show.
    fun registration(flowId: String?, cookie: String?): TemplateInstance {
        val response = fetchFlowOrRestart(flowId, "$kratosBrowserUrl/self-service/registration/browser") {
            kratosClient.getRegistrationFlow(it, cookie)
        }

        return registrationTemplate.data(response.toFormModel())
    }
}
