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

// home_widget resolves glance-appwidget:1.+ to alpha builds that require compileSdk 37 / AGP 9.1+.
// Water Reminder widgets use RemoteViews (HomeWidgetProvider), not Glance — pin a stable release.
subprojects {
    configurations.configureEach {
        resolutionStrategy.force("androidx.glance:glance-appwidget:1.1.1")
    }
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
