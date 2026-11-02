package me.hauke.quarkuskratos.auth

import io.quarkus.qute.Location
import io.quarkus.qute.Template
import io.quarkus.qute.TemplateInstance
import jakarta.enterprise.context.ApplicationScoped
import jakarta.inject.Inject
import org.eclipse.microprofile.config.inject.ConfigProperty
import org.eclipse.microprofile.rest.client.inject.RestClient

@ApplicationScoped
class LoginService @Inject constructor(
        @RestClient val kratosClient: KratosClient,
        @Location("auth/login.html") val loginTemplate: Template,
        @ConfigProperty(name = "kratos.browser-url") val kratosBrowserUrl: String,
) {
    fun login(flowId: String?, cookie: String?): TemplateInstance {
        val response = fetchFlowOrRestart(flowId, "$kratosBrowserUrl/self-service/login/browser") {
            kratosClient.getLoginFlow(it, cookie)
        }

        return loginTemplate.data(response.toFormModel())
    }
}
