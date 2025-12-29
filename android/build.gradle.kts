allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
    
    // Configure namespace for Android library projects (Flutter plugins)
    // This fixes the issue where Flutter plugins don't have namespace specified
    plugins.withId("com.android.library") {
        val manifestFile = project.file("src/main/AndroidManifest.xml")
        if (manifestFile.exists()) {
            val manifestContent = manifestFile.readText()
            val packageMatch = Regex("package=\"([^\"]+)\"").find(manifestContent)
            packageMatch?.let { match ->
                val namespace = match.groupValues[1]
                extensions.configure<com.android.build.gradle.LibraryExtension>("android") {
                    if (this.namespace.isNullOrBlank()) {
                        this.namespace = namespace
                    }
                }
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
