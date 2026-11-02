package me.hauke.quarkuskratos.auth

import io.quarkus.qute.TemplateData
import jakarta.ws.rs.WebApplicationException
import jakarta.ws.rs.core.Response
import java.net.URI

@TemplateData
data class FormModel(
        val flow: String,
        val message: String = "",
        val action: String,
        val method: String,
        val fields: List<FieldModel> = emptyList()
) {
    @TemplateData
    data class FieldModel(
            val id: String,
            val type: String,
            val value: String?,
            val name: String,
            val label: String,
            val required: Boolean,
            val message: String?
    )
}

// Renders every input node Kratos sends, the hidden ones and the submit buttons
// included. The buttons carry values Kratos needs, such as `method=password`, or
// `method=profile` on the first step of two-step registration, so a hand-written
// submit button would post an incomplete form.
fun KratosClient.KratosFlow.toFormModel() = FormModel(
        flow = id,
        message = ui.messages?.joinToString(";") { it.text } ?: "",
        action = ui.action,
        method = ui.method,
        fields = ui.nodes
                .filter { it.type == "input" && it.attributes.name != null }
                .map { node ->
                    val name = node.attributes.name!!
                    FormModel.FieldModel(
                            id = name,
                            type = node.attributes.type ?: "text",
                            value = node.attributes.value?.toString(),
                            name = name,
                            label = node.meta?.label?.text ?: name,
                            required = node.attributes.required,
                            message = node.messages.takeIf { it.isNotEmpty() }?.joinToString(";") { it.text }
                    )
                }
)

// A flow that is missing, has expired, or was started in another browser can't
// be rendered, so send the browser to Kratos to start a new one instead.
fun <T> fetchFlowOrRestart(flowId: String?, restartUrl: String, fetch: (String) -> T): T {
    val restart = WebApplicationException(Response.seeOther(URI(restartUrl)).build())
    if (flowId.isNullOrBlank()) throw restart
    return try {
        fetch(flowId)
    } catch (e: WebApplicationException) {
        if (e.response.status in listOf(403, 404, 410)) throw restart
        throw e
    }
}
