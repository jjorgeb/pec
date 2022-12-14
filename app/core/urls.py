# core/urls.py

from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path("admin/", admin.site.urls),
    path("sso/", include("sso.urls")),
    path("polls/", include("polls.urls")),
    path("cbvpolls/", include("cbvpolls.urls")),
]
