package me.hauke.quarkuskratos.recipe

import io.quarkus.qute.Location
import io.quarkus.qute.Template
import io.quarkus.qute.TemplateInstance
import me.hauke.quarkuskratos.auth.Secured
import javax.inject.Inject
import javax.ws.rs.GET
import javax.ws.rs.Path
import javax.ws.rs.Produces
import javax.ws.rs.core.MediaType


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