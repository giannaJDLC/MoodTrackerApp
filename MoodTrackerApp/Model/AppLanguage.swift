//
//  AppLanguage.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 12/16/25.
//

import Foundation

enum AppLanguage: String, CaseIterable, Identifiable, Codable {
    case english = "English"
    case spanish = "Español"
    
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
            case "NotificationSectionTitle": return "Notification Check-in Times"
                
            // --- Notifications ---
            case "TimeToCheckInTitle": return "Mood Check-in: %@"
            case "TimeToCheckInBody": return "Time to check in! How are you feeling?"
//            case "Times Saved Alert Title": return "Times Saved"
//            case "Times Saved Alert Message": return "Your new notification times have been scheduled."

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
            case "TimeRemainingCreate": return "You have %@ to create your entry"
            case "TimeRemainingEdit": return "You have %@ to edit your entry"
            case "SlotBlockedTitle": return "Entry Blocked"
            case "SlotBlockedMessage": return "You can only record an entry for the %@ slot during its allotted time (%@)."
                
            // --- Analysis
            case "AnalysisWeeklyTitle": return "Weekly Analysis: Time of Day Patterns"
            case "AnalysisMonthlyTitle": return "Monthly Analysis: Weekly Averages"
            case "AnalysisUsageTitle": return "Usage Analysis: Missed Check-ins (Last 30 Days)"
            case "NoEntries7Days": return "No entries in the last 7 days."
            case "NotEnoughMonthly": return "Not enough data (less than 2 weeks) for monthly analysis."
            case "NotEnoughUsage": return "Not enough data to track usage."
            case "SlotLabel": return "%@ Slot:"
            case "WeekOf": return "Week of %@"
            case "AvgMood": return "Avg Mood:"
            case "CommonThought": return "Most Common Thought:"
            case "TotalExpected": return "Total Expected Inputs:"
            case "TotalRecorded": return "Total Recorded Inputs:"
            case "MissedCheckins": return "Missed Check-ins:"
            case "UsageSuggestion": return "This suggests **%@%%** of check-ins were missed."
                
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
            case "NotificationSectionTitle": return "Horarios de Notificación"

            // --- Notifications ---
            case "TimeToCheckInTitle": return "Registra Tu Animo: %@"
            case "TimeToCheckInBody": return "¡Es hora de registrarse! ¿Cómo te sientes?"
//            case "Times Saved Alert Title": return "Horarios Guardados"
//            case "Times Saved Alert Message": return "Tus nuevos horarios de notificación han sido programados."

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
            case "TimeRemainingCreate": return "Tienes %@ para crear tu registro"
            case "TimeRemainingEdit": return "Tienes %@ para editar tu registro"
            case "SlotBlockedTitle": return "Registro Bloqueado"
            case "SlotBlockedMessage": return "Solo puedes registrar una entrada para el espacio de la %@ durante su tiempo asignado (%@)."

            // --- Analysis ---
            case "AnalysisWeeklyTitle": return "Análisis Semanal: Patrones por Momento del Día"
            case "AnalysisMonthlyTitle": return "Análisis Mensual: Promedios Semanales"
            case "AnalysisUsageTitle": return "Análisis de Uso: Registros Perdidos (Últimos 30 Días)"
            case "NoEntries7Days": return "No hay registros en los últimos 7 días."
            case "NotEnoughMonthly": return "No hay suficientes datos (menos de 2 semanas) para el análisis mensual."
            case "NotEnoughUsage": return "No hay suficientes datos para rastrear el uso."
            case "SlotLabel": return "Espacio de %@:"
            case "WeekOf": return "Semana del %@"
            case "AvgMood": return "Ánimo Promedio:"
            case "CommonThought": return "Pensamiento más Común:"
            case "TotalExpected": return "Entradas Esperadas:"
            case "TotalRecorded": return "Entradas Registradas:"
            case "MissedCheckins": return "Registros No Ingresados:"
            case "UsageSuggestion": return "Esto sugiere que no ingresó el **%@%%** de los registros."

            default: return key
            }
        }
    }
}


