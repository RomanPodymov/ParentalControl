// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
enum L10n {
    enum AddKidScreen {
        /// Add kid
        static let title = L10n.tr("Localizable", "add_kid_screen.title", fallback: "Add kid")
        enum ButtoAdd {
            /// Add kid
            static let title = L10n.tr("Localizable", "add_kid_screen.butto_add.title", fallback: "Add kid")
        }

        enum FieldEmail {
            /// Email
            static let placeholder = L10n.tr("Localizable", "add_kid_screen.field_email.placeholder", fallback: "Email")
        }
    }

    enum AddtimeslotScreen {
        /// Add time
        static let labelAdding = L10n.tr("Localizable", "addtimeslot_screen.label_adding", fallback: "Add time")
        /// Remove time
        static let labelRemoving = L10n.tr("Localizable", "addtimeslot_screen.label_removing", fallback: "Remove time")
        enum ButtonSave {
            /// Save
            static let title = L10n.tr("Localizable", "addtimeslot_screen.button_save.title", fallback: "Save")
        }

        enum FieldDescription {
            /// Description
            static let placeholder = L10n.tr("Localizable", "addtimeslot_screen.field_description.placeholder", fallback: "Description")
        }

        enum FieldDuration {
            /// Duration
            static let placeholder = L10n.tr("Localizable", "addtimeslot_screen.field_duration.placeholder", fallback: "Duration ")
        }

        enum FieldFrom {
            /// From
            static let placeholder = L10n.tr("Localizable", "addtimeslot_screen.field_from.placeholder", fallback: "From ")
        }
    }

    enum Alert {
        /// OK
        static let defaultButton = L10n.tr("Localizable", "alert.default_button", fallback: "OK")
        /// Localizable.strings
        ///   ParentalControl
        ///
        ///   Created by Roman Podymov on 14.12.2023.
        static let defaultTitle = L10n.tr("Localizable", "alert.default_title", fallback: "Warning")
        /// Are you sure you want to delete account?
        static let deleteAccountText = L10n.tr("Localizable", "alert.delete_account_text", fallback: "Are you sure you want to delete account?")
        /// Are you sure you want to delete time slot?
        static let deleteTimeSlotText = L10n.tr("Localizable", "alert.delete_time_slot_text", fallback: "Are you sure you want to delete time slot?")
        /// No
        static let noButton = L10n.tr("Localizable", "alert.no_button", fallback: "No")
        /// Yes
        static let yesButton = L10n.tr("Localizable", "alert.yes_button", fallback: "Yes")
    }

    enum ChangepasswordScreen {
        /// Change password
        static let title = L10n.tr("Localizable", "changepassword_screen.title", fallback: "Change password")
        enum ButtonSavepassword {
            /// Save
            static let title = L10n.tr("Localizable", "changepassword_screen.button_savepassword.title", fallback: "Save")
        }

        enum FieldEmail {
            /// Password
            static let placeholder = L10n.tr("Localizable", "changepassword_screen.field_email.placeholder", fallback: "Password")
        }
    }

    enum Error {
        /// No time space left
        static let cannotAddTimeSlotBecauseNoTimeLeft = L10n.tr("Localizable", "error.cannot_add_time_slot_because_no_time_left", fallback: "No time space left")
        /// Kid already has a parent
        static let kidAlreadyHasParent = L10n.tr("Localizable", "error.kid_already_has_parent", fallback: "Kid already has a parent")
        /// Kid for id not found
        static let kidForIdNotFound = L10n.tr("Localizable", "error.kid_for_id_not_found", fallback: "Kid for id not found")
        /// Kid attempts to sign in as a parent
        static let kidTryingToUseParentApp = L10n.tr("Localizable", "error.kid_trying_to_use_parent_app", fallback: "Kid attempts to sign in as a parent")
        /// Object is not existing anymore
        static let nilSelf = L10n.tr("Localizable", "error.nil_self", fallback: "Object is not existing anymore")
        /// User is not authorised
        static let noCurrentUserWhenRequired = L10n.tr("Localizable", "error.no_current_user_when_required", fallback: "User is not authorised")
        /// Kid not found. Register a new kid using main menu.
        static let noKidForEmailFound = L10n.tr("Localizable", "error.no_kid_for_email_found", fallback: "Kid not found. Register a new kid using main menu.")
        /// Parent attempts to sign in as a kid
        static let parentTryingToUseKidApp = L10n.tr("Localizable", "error.parent_trying_to_use_kid_app", fallback: "Parent attempts to sign in as a kid")
        /// Passwords should be same
        static let passwordsAreDiffent = L10n.tr("Localizable", "error.passwords_are_diffent", fallback: "Passwords should be same")
    }

    enum KidsScreen {
        /// Add kids by pressing +
        static let emptyMessage = L10n.tr("Localizable", "kids_screen.empty_message", fallback: "Add kids by pressing +")
        /// Here is the list of your kids
        static let message = L10n.tr("Localizable", "kids_screen.message", fallback: "Here is the list of your kids")
        /// Kids
        static let title = L10n.tr("Localizable", "kids_screen.title", fallback: "Kids")
    }

    enum KidsTimeSlotsScreen {
        ///  minutes available
        static let message = L10n.tr("Localizable", "kids_time_slots_screen.message", fallback: " minutes available")
        /// Started at
        static let startDateMessage = L10n.tr("Localizable", "kids_time_slots_screen.start_date_message", fallback: "Started at")
        /// Time slots
        static let title = L10n.tr("Localizable", "kids_time_slots_screen.title", fallback: "Time slots")
        /// Was added at
        static let wasAddedMessage = L10n.tr("Localizable", "kids_time_slots_screen.was_added_message", fallback: "Was added at")
    }

    enum NewhomeScreen {
        enum ButtonSignout {
            /// (Sign out)
            static let title = L10n.tr("Localizable", "newhome_screen.button_signout.title", fallback: "(Sign out)")
        }

        enum Label {
            /// Available credit:
            static let availableCredit = L10n.tr("Localizable", "newhome_screen.label.available_credit", fallback: "Available credit:")
        }
    }

    enum RegisterScreen {
        /// Register
        static let title = L10n.tr("Localizable", "register_screen.title", fallback: "Register")
        enum ButtonRegister {
            /// Register
            static let title = L10n.tr("Localizable", "register_screen.button_register.title", fallback: "Register")
        }

        enum FieldEmail {
            /// Email
            static let placeholder = L10n.tr("Localizable", "register_screen.field_email.placeholder", fallback: "Email")
        }

        enum FieldPassword {
            /// Password
            static let placeholder = L10n.tr("Localizable", "register_screen.field_password.placeholder", fallback: "Password")
        }

        enum FieldPasswordAgain {
            /// Password again
            static let placeholder = L10n.tr("Localizable", "register_screen.field_password_again.placeholder", fallback: "Password again")
        }

        enum Message {
            /// Please check your email
            static let title = L10n.tr("Localizable", "register_screen.message.title", fallback: "Please check your email")
        }
    }

    enum ResetpasswordScreen {
        /// Reset password
        static let title = L10n.tr("Localizable", "resetpassword_screen.title", fallback: "Reset password")
        enum ButtonResetpassword {
            /// Send email with password
            static let title = L10n.tr("Localizable", "resetpassword_screen.button_resetpassword.title", fallback: "Send email with password")
        }

        enum FieldEmail {
            /// Email
            static let placeholder = L10n.tr("Localizable", "resetpassword_screen.field_email.placeholder", fallback: "Email")
        }

        enum Message {
            /// Check your email
            static let title = L10n.tr("Localizable", "resetpassword_screen.message.title", fallback: "Check your email")
        }
    }

    enum SigninScreen {
        /// Is it parent
        static let switchLeft = L10n.tr("Localizable", "signin_screen.switch_left", fallback: "Is it parent ")
        ///  or kid
        static let switchRight = L10n.tr("Localizable", "signin_screen.switch_right", fallback: " or kid")
        /// Sign in
        static let title = L10n.tr("Localizable", "signin_screen.title", fallback: "Sign in")
        enum ButtonRegister {
            /// Sign up
            static let title = L10n.tr("Localizable", "signin_screen.button_register.title", fallback: "Sign up")
        }

        enum ButtonResetpassword {
            /// Reset password
            static let title = L10n.tr("Localizable", "signin_screen.button_resetpassword.title", fallback: "Reset password")
        }

        enum ButtonSignin {
            /// Sign in
            static let title = L10n.tr("Localizable", "signin_screen.button_signin.title", fallback: "Sign in")
        }

        enum FieldEmail {
            /// Email
            static let placeholder = L10n.tr("Localizable", "signin_screen.field_email.placeholder", fallback: "Email")
        }

        enum FieldPassword {
            /// Password
            static let placeholder = L10n.tr("Localizable", "signin_screen.field_password.placeholder", fallback: "Password")
        }
    }

    enum UserScreen {
        /// Hello,
        static let greeting = L10n.tr("Localizable", "user_screen.greeting", fallback: "Hello, ")
        /// User
        static let title = L10n.tr("Localizable", "user_screen.title", fallback: "User")
        enum ButtonChangepassword {
            /// Change password
            static let title = L10n.tr("Localizable", "user_screen.button_changepassword.title", fallback: "Change password")
        }

        enum ButtonChangephoto {
            /// Change photo
            static let title = L10n.tr("Localizable", "user_screen.button_changephoto.title", fallback: "Change photo")
        }

        enum ButtonDeleteaccount {
            /// Delete account
            static let title = L10n.tr("Localizable", "user_screen.button_deleteaccount.title", fallback: "Delete account")
        }

        enum ButtonLogout {
            /// Sign out
            static let title = L10n.tr("Localizable", "user_screen.button_logout.title", fallback: "Sign out")
        }
    }
}

// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
        let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle: Bundle = {
        #if SWIFT_PACKAGE
            return Bundle.module
        #else
            return Bundle(for: BundleToken.self)
        #endif
    }()
}

// swiftlint:enable convenience_type
