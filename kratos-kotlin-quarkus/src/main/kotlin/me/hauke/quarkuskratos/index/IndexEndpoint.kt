package me.hauke.quarkuskratos.index

import io.quarkus.qute.Location
import io.quarkus.qute.Template
import io.quarkus.qute.TemplateInstance
import jakarta.inject.Inject
import jakarta.ws.rs.GET
import jakarta.ws.rs.Path
import jakarta.ws.rs.Produces
import jakarta.ws.rs.core.MediaType
import org.eclipse.microprofile.config.inject.ConfigProperty

@Path("") // ①
class IndexEndpoint @Inject constructor(
        @Location("index/index.html") val index: Template, // ②
        @ConfigProperty(name = "kratos.browser-url") val kratosBrowserUrl: String
) {

    @GET
    @Produces(MediaType.TEXT_HTML)
    fun index(): TemplateInstance =
            index.data(
                    "title", "My first template", // ③
                    "text", "Hello 👋🏻",
                    "kratosUrl", kratosBrowserUrl
            )
}
