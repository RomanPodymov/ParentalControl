package com.parentalcontrol.kmm.shared

class TryingKMM {
    fun screenLabel(language: String): String {
        if (language == "cs") {
            return "Tady máte seznam Vašich dětí"
        } else {
            return "Here is the list of your kids"
        }
    }
}
