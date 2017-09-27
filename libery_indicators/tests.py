from .models import PercentLibraryPerAreaOfActivity
from .models import PercentPublicOrPrivateLibrary
from datetime import datetime


class TestPercentLibraryPerAreaOfActivity(object):

    def test_total_library_per_area_of_activity(self):
        PercentLibraryPerAreaOfActivity.drop_collection()
        totalLibraryPerAreaOfActivity = {'activity area': 20}
        libery_indicator = PercentLibraryPerAreaOfActivity(totalLibraryPerAreaOfActivity, 20, datetime.now())
        libery_indicator.save()
        querry = PercentLibraryPerAreaOfActivity.objects.first()
        assert querry._totalLibraryPerAreaOfActivity == totalLibraryPerAreaOfActivity

    def test_total_library(self):
        PercentLibraryPerAreaOfActivity.drop_collection()
        totalLibrary = 50
        libery_indicator = PercentLibraryPerAreaOfActivity({'activity area': 20}, totalLibrary, datetime.now())
        libery_indicator.save()
        querry = PercentLibraryPerAreaOfActivity.objects.first()
        assert querry._totalLibrary == totalLibrary


class TestPercentPublicOrPrivateLibrary(object):

    def test_total_public_library(self):
        PercentPublicOrPrivateLibrary.drop_collection()
        totalPublicLibrary = 50
        libery_indicator = PercentPublicOrPrivateLibrary(totalPublicLibrary, 20, 100, datetime.now())
        libery_indicator.save()
        querry = PercentPublicOrPrivateLibrary.objects.first()
        assert querry._totalPublicLibrary == totalPublicLibrary

    def test_total_private_library(self):
        PercentPublicOrPrivateLibrary.drop_collection()
        totalPrivateLibrary = 50
        libery_indicator = PercentPublicOrPrivateLibrary(20, totalPrivateLibrary, 100, datetime.now())
        libery_indicator.save()
        querry = PercentPublicOrPrivateLibrary.objects.first()
        assert querry._totalPrivateLibrary == totalPrivateLibrary

    def test_total_library(self):
        PercentPublicOrPrivateLibrary.drop_collection()
        totalLibrary = 50
        libery_indicator = PercentPublicOrPrivateLibrary(20, 20, totalLibrary, datetime.now())
        libery_indicator.save()
        querry = PercentPublicOrPrivateLibrary.objects.first()
        assert querry._totalLibrary == totalLibrary
