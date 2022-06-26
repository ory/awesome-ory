package me.hauke.quarkuskratos.auth

import io.quarkus.qute.Template
import io.quarkus.qute.TemplateInstance
import io.quarkus.qute.Location
import org.eclipse.microprofile.rest.client.inject.RestClient
import javax.enterprise.context.ApplicationScoped
import javax.inject.Inject

@ApplicationScoped
class LoginService @Inject constructor(
        @RestClient val kratosClient: KratosClient,
        @Location("auth/login.html") val loginTemplate: Template,
) {
    fun login(flowId: String): TemplateInstance {
        val response = kratosClient.getLoginFlow(flowId)

        val model = LoginModel(
                flow = flowId,
                message = response.messages?.toString() ?: "",
                action = response.methods["password"]?.config?.action ?: "",
                fields = response.methods["password"]?.config?.fields?.map { field ->
                    LoginModel.LoginFieldModel(
                            id = field.name,
                            type = field.type,
                            value = field.value,
                            name = field.name,
                            message = field.messages?.joinToString(";") { it.text }
                    )
                } ?: emptyList()
        )

        return loginTemplate.data(model)
    }


    data class LoginModel(
            val flow: String,
            val message: String = "",
            val action: String,
            val fields: List<LoginFieldModel> = emptyList()
    ) {
        data class LoginFieldModel(
                val id: String,
                val type: String,
                val value: String?,
                val name: String,
                val message: String?
        )
    }
}
