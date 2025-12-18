//
//  AppLanguage.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 12/16/25.
//

import Foundation

enum AppLanguage: String, CaseIterable, Identifiable, Codable {
    case english = "English"
    case spanish = "Spanish"
    
    var id: String { self.rawValue }
    
    // Mock translation utility for this single file
    func localize(_ key: String) -> String {
        switch self {
        case .english:
            switch key {
            // --- Tabs & Titles ---
            case "EntryTitle": return "New Entry"
            case "HistoryTitle": return "Mood History"
            case "AnalysisTitle": return "Insights"
            case "SettingsTitle": return "Settings"
            case "SaveButton": return "Save and Update Notifications"
            case "RecordButton": return "Record Mood Entry"
                
            // --- Settings ---
            case "LanguageSettingsTitle": return "Language"

            // --- Notifications ---
            case "NotificationSectionTitle": return "Notification Check-in Times"
            case "Times Saved Alert Title": return "Times Saved"
            case "Times Saved Alert Message": return "Your new notification times have been scheduled."

            // --- Time Slots ---
            case "Morning": return "Morning"
            case "Afternoon": return "Afternoon"
            case "Evening": return "Evening"

            // --- Moods (Keys must match the enum rawValue) ---
            case "happy": return "Happy"
            case "neutral": return "Neutral"
            case "sad": return "Sad"
            case "angry": return "Angry"
            case "excited": return "Excited"
            case "overwhelmed": return "Overwhelmed"
            
            // --- Thought Categories (Keys must match the enum rawValue) ---
            case "practical": return "Practical"
            case "emotional": return "Emotional"
            case "inspirational": return "Motivational"
            case "other": return "Other"
            
            // --- Mood Entry View Strings ---
            case "SelectMood": return "How are you feeling?"
            case "SelectCategory": return "How would you describe your thoughts?"
            case "DailyCheckinTitle": return "Daily Check-in"
            case "SaveEntryButton": return "Save Entry"
            case "UpdateEntryButton": return "Update Entry"
            case "EntrySaved": return "Entry Successfully Saved!"
            case "EntryUpdated": return "Entry Successfully Updated!"
            case "ErrorSaving": return "An error occurred while saving."
                
            // --- Time Slot Blockers & Countdown ---
            case "TimeRemainingCreate": return "You have %s to create your entry" // %s is the time
            case "TimeRemainingEdit": return "You have %s to edit your entry"    // %s is the time
            case "SlotBlockedTitle": return "Entry Blocked"
            case "SlotBlockedMessage": return "You can only record an entry for the %s slot during its allotted time (%s)." // 1st %s is slot name, 2nd %s is time range
                
            default: return key
            }
        case .spanish:
            switch key {
            // --- Tabs & Titles ---
            case "EntryTitle": return "Nuevo Registro"
            case "HistoryTitle": return "Historial de Ánimo"
            case "AnalysisTitle": return "Análisis"
            case "SettingsTitle": return "Ajustes"
            case "SaveButton": return "Guardar y Actualizar Notificaciones"
            case "RecordButton": return "Registrar Estado de Ánimo"

            // --- Settings ---
            case "LanguageSettingsTitle": return "Idioma"
                
            // --- Notifications ---
            case "NotificationSectionTitle": return "Horarios de Notificación"
            case "Times Saved Alert Title": return "Horarios Guardados"
            case "Times Saved Alert Message": return "Tus nuevos horarios de notificación han sido programados."

            // --- Time Slots ---
            case "Morning": return "Mañana"
            case "Afternoon": return "Tarde"
            case "Evening": return "Noche"

            // --- Moods (Keys must match the enum rawValue) ---
            case "happy": return "Contento"
            case "neutral": return "Neutral"
            case "sad": return "Triste"
            case "angry": return "Enojado"
            case "excited": return "Emocionado"
            case "overwhelmed": return "Abrumado"

            // --- Thought Categories (Keys must match the enum rawValue) ---
            case "practical": return "Práctico"
            case "emotional": return "Emocional"
            case "inspirational": return "Motivacional"
            case "other": return "Otro"
            
            // --- Mood Entry View Strings ---
            case "SelectMood": return "¿Cómo te sientes?"
            case "SelectCategory": return "¿Cómo son tus pensamientos actuales?"
            case "DailyCheckinTitle": return "Registro Diario"
            case "SaveEntryButton": return "Guardar Registro"
            case "UpdateEntryButton": return "Actualizar Registro"
            case "EntrySaved": return "¡Registro Guardado!"
            case "EntryUpdated": return "¡Registro Actualizado!"
            case "ErrorSaving": return "Ocurrió un error al guardar."

            // --- Time Slot Blockers & Countdown ---
            case "TimeRemainingCreate": return "Tienes %s para crear tu registro" // %s is the time
            case "TimeRemainingEdit": return "Tienes %s para editar tu registro"    // %s is the time
            case "SlotBlockedTitle": return "Registro Bloqueado"
            case "SlotBlockedMessage": return "Solo puedes registrar una entrada para el espacio de la %s durante su tiempo asignado (%s)." // 1st %s is slot name, 2nd %s is time range



            default: return key
            }
        }
    }
}
