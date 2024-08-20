import org.jetbrains.kotlin.gradle.plugin.mpp.apple.XCFramework

plugins {
    kotlin("multiplatform")
}

kotlin {
   val xcf = XCFramework()
   val iosTargets = listOf(iosX64(), iosArm64(), iosSimulatorArm64())

   iosTargets.forEach {
      it.binaries.framework {
          baseName = "ParentalControlCommon"
          xcf.add(this)
      }
   }
}
