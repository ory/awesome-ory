package me.hauke.quarkuskratos.recipe

import io.quarkus.qute.Location
import io.quarkus.qute.Template
import io.quarkus.qute.TemplateInstance
import me.hauke.quarkuskratos.auth.Secured
import jakarta.inject.Inject
import jakarta.ws.rs.GET
import jakarta.ws.rs.Path
import jakarta.ws.rs.Produces
import jakarta.ws.rs.core.MediaType


@Path("/recipe")
class RecipeEndpoint @Inject constructor(
        @Location("recipe/recipe.html") val recipe: Template
) {

    @Secured
    @GET
    @Produces(MediaType.TEXT_HTML)
    fun get(): TemplateInstance =
            recipe.instance()
}