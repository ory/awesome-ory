package me.hauke.quarkuskratos.auth

import io.quarkus.qute.Location
import io.quarkus.qute.Template
import io.quarkus.qute.TemplateInstance
import org.eclipse.microprofile.rest.client.inject.RestClient
import java.util.logging.Logger
import javax.enterprise.context.ApplicationScoped
import javax.inject.Inject

@ApplicationScoped
class RegistrationService @Inject constructor(
    @RestClient val kratosClient: KratosClient,
    @Location("auth/registration.html") val registrationTemplate: Template,
) {
    private val logger: Logger = Logger.getLogger("RegistrationService")
    fun registration(flowId: String): TemplateInstance {
        val response = kratosClient.getRegistrationFlow(flowId)
        logger.info(response.toString())

        val model = RegistrationModel(
                flow = flowId,
                message = response.messages?.toString() ?: "",
                action = response.methods["password"]?.config?.action ?: "",
                fields = response.methods["password"]?.config?.fields?.map { field ->
                    RegistrationModel.RegistrationFieldModel(
                            id = field.name,
                            type = field.type,
                            value = field.value,
                            name = field.name,
                            message = field.messages?.joinToString(";") { it.text }
                    )
                } ?: emptyList()
        )

        return registrationTemplate.data(model)
    }


    data class RegistrationModel(
            val flow: String,
            val message: String = "",
            val action: String,
            val fields: List<RegistrationFieldModel> = emptyList(),
    ) {
        data class RegistrationFieldModel(
                val id: String,
                val type: String,
                val value: String?,
                val name: String,
                val message: String?
        )
    }
}
