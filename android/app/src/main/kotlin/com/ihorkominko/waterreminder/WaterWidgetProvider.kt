package com.ihorkominko.waterreminder

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

// Reads WidgetDataKeys written from Flutter via home_widget.
class WaterWidgetProvider : HomeWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences,
    ) {
        val todayMl = widgetData.getInt("today_ml", 0)
        val goalMl = widgetData.getInt("goal_ml", 2000)
        val percent = widgetData.getInt("percent", 0)
        val remaining = widgetData.getInt("remaining_ml", goalMl - todayMl)

        appWidgetIds.forEach { id ->
            val views = RemoteViews(context.packageName, R.layout.water_widget).apply {
                setTextViewText(R.id.widget_percent, "$percent%")
                setTextViewText(
                    R.id.widget_subtitle,
                    if (todayMl >= goalMl) "Goal reached" else "$todayMl / $goalMl ml · $remaining left",
                )
            }
            appWidgetManager.updateAppWidget(id, views)
        }
    }
}
