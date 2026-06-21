plugins {
    application
    java
}

repositories {
    mavenCentral()
}

dependencies {
    // This dependency is used by the application.
    implementation(libs.guava)
}

java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(21)
    }

    // Define the custom source directory
    sourceSets {
        main {
            java {
                setSrcDirs(listOf("src"))
            }
        }
    }
}

application {
    // Define the main class for the application.
    mainClass = "org.Clase"
}

tasks.jar {
    manifest {
        attributes["Main-Class"] = application.mainClass.get() // Ensure Main-Class is set in the manifest
    }
}

tasks.javadoc {
    // Specify source files for Javadoc generation
    source = sourceSets["main"].allJava

    // Set the destination directory for the generated docs
    destinationDir = file("$buildDir/docs/javadoc")

    // Optional: configure the title of the generated docs
    options {
        header = "My Java Project Documentation"
    }
}
