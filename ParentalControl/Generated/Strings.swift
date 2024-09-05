// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum AddKidScreen {
    /// Add kid
    internal static let title = L10n.tr("Localizable", "add_kid_screen.title", fallback: "Add kid")
    internal enum ButtoAdd {
      /// Add kid
      internal static let title = L10n.tr("Localizable", "add_kid_screen.butto_add.title", fallback: "Add kid")
    }
    internal enum FieldEmail {
      /// Email
      internal static let placeholder = L10n.tr("Localizable", "add_kid_screen.field_email.placeholder", fallback: "Email")
    }
  }
  internal enum AddtimeslotScreen {
    /// Add time
    internal static let labelAdding = L10n.tr("Localizable", "addtimeslot_screen.label_adding", fallback: "Add time")
    /// Remove time
    internal static let labelRemoving = L10n.tr("Localizable", "addtimeslot_screen.label_removing", fallback: "Remove time")
    internal enum ButtonSave {
      /// Save
      internal static let title = L10n.tr("Localizable", "addtimeslot_screen.button_save.title", fallback: "Save")
    }
    internal enum FieldDescription {
      /// Description
      internal static let placeholder = L10n.tr("Localizable", "addtimeslot_screen.field_description.placeholder", fallback: "Description")
    }
    internal enum FieldDuration {
      /// Duration 
      internal static let placeholder = L10n.tr("Localizable", "addtimeslot_screen.field_duration.placeholder", fallback: "Duration ")
    }
    internal enum FieldFrom {
      /// From 
      internal static let placeholder = L10n.tr("Localizable", "addtimeslot_screen.field_from.placeholder", fallback: "From ")
    }
  }
  internal enum Alert {
    /// OK
    internal static let defaultButton = L10n.tr("Localizable", "alert.default_button", fallback: "OK")
    /// Localizable.strings
    ///   ParentalControl
    /// 
    ///   Created by Roman Podymov on 14.12.2023.
    internal static let defaultTitle = L10n.tr("Localizable", "alert.default_title", fallback: "Warning")
    /// Are you sure you want to delete account?
    internal static let deleteAccountText = L10n.tr("Localizable", "alert.delete_account_text", fallback: "Are you sure you want to delete account?")
    /// Are you sure you want to delete time slot?
    internal static let deleteTimeSlotText = L10n.tr("Localizable", "alert.delete_time_slot_text", fallback: "Are you sure you want to delete time slot?")
    /// No
    internal static let noButton = L10n.tr("Localizable", "alert.no_button", fallback: "No")
    /// Yes
    internal static let yesButton = L10n.tr("Localizable", "alert.yes_button", fallback: "Yes")
  }
  internal enum ChangepasswordScreen {
    /// Nastavit heslo
    internal static let title = L10n.tr("Localizable", "changepassword_screen.title", fallback: "Nastavit heslo")
    internal enum ButtonSavepassword {
      /// Ulozit
      internal static let title = L10n.tr("Localizable", "changepassword_screen.button_savepassword.title", fallback: "Ulozit")
    }
    internal enum FieldEmail {
      /// Heslo
      internal static let placeholder = L10n.tr("Localizable", "changepassword_screen.field_email.placeholder", fallback: "Heslo")
    }
  }
  internal enum Error {
    /// No time space left
    internal static let cannotAddTimeSlotBecauseNoTimeLeft = L10n.tr("Localizable", "error.cannot_add_time_slot_because_no_time_left", fallback: "No time space left")
    /// Kid already has a parent
    internal static let kidAlreadyHasParent = L10n.tr("Localizable", "error.kid_already_has_parent", fallback: "Kid already has a parent")
    /// Kid for id not found
    internal static let kidForIdNotFound = L10n.tr("Localizable", "error.kid_for_id_not_found", fallback: "Kid for id not found")
    /// Kid attempts to sign in as a parent
    internal static let kidTryingToUseParentApp = L10n.tr("Localizable", "error.kid_trying_to_use_parent_app", fallback: "Kid attempts to sign in as a parent")
    /// Object is not existing anymore
    internal static let nilSelf = L10n.tr("Localizable", "error.nil_self", fallback: "Object is not existing anymore")
    /// User is not authorised
    internal static let noCurrentUserWhenRequired = L10n.tr("Localizable", "error.no_current_user_when_required", fallback: "User is not authorised")
    /// Kid not found. Register a new kid using main menu.
    internal static let noKidForEmailFound = L10n.tr("Localizable", "error.no_kid_for_email_found", fallback: "Kid not found. Register a new kid using main menu.")
    /// Parent attempts to sign in as a kid
    internal static let parentTryingToUseKidApp = L10n.tr("Localizable", "error.parent_trying_to_use_kid_app", fallback: "Parent attempts to sign in as a kid")
    /// Passwords should be same
    internal static let passwordsAreDiffent = L10n.tr("Localizable", "error.passwords_are_diffent", fallback: "Passwords should be same")
  }
  internal enum KidsScreen {
    /// Přídejte své děti přes tlačítko +
    internal static let emptyMessage = L10n.tr("Localizable", "kids_screen.empty_message", fallback: "Přídejte své děti přes tlačítko +")
    /// Here is the list of your kids
    internal static let message = L10n.tr("Localizable", "kids_screen.message", fallback: "Here is the list of your kids")
    /// Kids
    internal static let title = L10n.tr("Localizable", "kids_screen.title", fallback: "Kids")
  }
  internal enum KidsTimeSlotsScreen {
    ///  minutes available
    internal static let message = L10n.tr("Localizable", "kids_time_slots_screen.message", fallback: " minutes available")
    /// Started at
    internal static let startDateMessage = L10n.tr("Localizable", "kids_time_slots_screen.start_date_message", fallback: "Started at")
    /// Time slots
    internal static let title = L10n.tr("Localizable", "kids_time_slots_screen.title", fallback: "Time slots")
    /// Was added at
    internal static let wasAddedMessage = L10n.tr("Localizable", "kids_time_slots_screen.was_added_message", fallback: "Was added at")
  }
  internal enum NewhomeScreen {
    internal enum ButtonSignout {
      /// (Sign out)
      internal static let title = L10n.tr("Localizable", "newhome_screen.button_signout.title", fallback: "(Sign out)")
    }
    internal enum Label {
      /// Available credit:
      internal static let availableCredit = L10n.tr("Localizable", "newhome_screen.label.available_credit", fallback: "Available credit:")
    }
  }
  internal enum RegisterScreen {
    /// Register
    internal static let title = L10n.tr("Localizable", "register_screen.title", fallback: "Register")
    internal enum ButtonRegister {
      /// Register
      internal static let title = L10n.tr("Localizable", "register_screen.button_register.title", fallback: "Register")
    }
    internal enum FieldEmail {
      /// Email
      internal static let placeholder = L10n.tr("Localizable", "register_screen.field_email.placeholder", fallback: "Email")
    }
    internal enum FieldPassword {
      /// Password
      internal static let placeholder = L10n.tr("Localizable", "register_screen.field_password.placeholder", fallback: "Password")
    }
    internal enum FieldPasswordAgain {
      /// Password again
      internal static let placeholder = L10n.tr("Localizable", "register_screen.field_password_again.placeholder", fallback: "Password again")
    }
    internal enum Message {
      /// Please check your email
      internal static let title = L10n.tr("Localizable", "register_screen.message.title", fallback: "Please check your email")
    }
  }
  internal enum ResetpasswordScreen {
    /// Resetovat heslo
    internal static let title = L10n.tr("Localizable", "resetpassword_screen.title", fallback: "Resetovat heslo")
    internal enum ButtonResetpassword {
      /// Poslat email s heslem
      internal static let title = L10n.tr("Localizable", "resetpassword_screen.button_resetpassword.title", fallback: "Poslat email s heslem")
    }
    internal enum FieldEmail {
      /// Email
      internal static let placeholder = L10n.tr("Localizable", "resetpassword_screen.field_email.placeholder", fallback: "Email")
    }
    internal enum Message {
      /// Skontrolujte svuj email
      internal static let title = L10n.tr("Localizable", "resetpassword_screen.message.title", fallback: "Skontrolujte svuj email")
    }
  }
  internal enum SigninScreen {
    /// Is it parent 
    internal static let switchLeft = L10n.tr("Localizable", "signin_screen.switch_left", fallback: "Is it parent ")
    ///  or kid
    internal static let switchRight = L10n.tr("Localizable", "signin_screen.switch_right", fallback: " or kid")
    /// Sign in
    internal static let title = L10n.tr("Localizable", "signin_screen.title", fallback: "Sign in")
    internal enum ButtonRegister {
      /// Sign up
      internal static let title = L10n.tr("Localizable", "signin_screen.button_register.title", fallback: "Sign up")
    }
    internal enum ButtonResetpassword {
      /// Reset password
      internal static let title = L10n.tr("Localizable", "signin_screen.button_resetpassword.title", fallback: "Reset password")
    }
    internal enum ButtonSignin {
      /// Sign in
      internal static let title = L10n.tr("Localizable", "signin_screen.button_signin.title", fallback: "Sign in")
    }
    internal enum FieldEmail {
      /// Email
      internal static let placeholder = L10n.tr("Localizable", "signin_screen.field_email.placeholder", fallback: "Email")
    }
    internal enum FieldPassword {
      /// Password
      internal static let placeholder = L10n.tr("Localizable", "signin_screen.field_password.placeholder", fallback: "Password")
    }
  }
  internal enum UserScreen {
    /// Hello, 
    internal static let greeting = L10n.tr("Localizable", "user_screen.greeting", fallback: "Hello, ")
    /// User
    internal static let title = L10n.tr("Localizable", "user_screen.title", fallback: "User")
    internal enum ButtonChangepassword {
      /// Change password
      internal static let title = L10n.tr("Localizable", "user_screen.button_changepassword.title", fallback: "Change password")
    }
    internal enum ButtonChangephoto {
      /// Change photo
      internal static let title = L10n.tr("Localizable", "user_screen.button_changephoto.title", fallback: "Change photo")
    }
    internal enum ButtonDeleteaccount {
      /// Delete account
      internal static let title = L10n.tr("Localizable", "user_screen.button_deleteaccount.title", fallback: "Delete account")
    }
    internal enum ButtonLogout {
      /// Sign out
      internal static let title = L10n.tr("Localizable", "user_screen.button_logout.title", fallback: "Sign out")
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
