from .models import PercentLibraryPerAreaOfActivity
from datetime import datetime


class TestPercentLibraryPerAreaOfActivity(object):

    def test_total_library_per_area_of_activity(self):
        PercentLibraryPerAreaOfActivity.drop_collection()
        totalLibraryPerAreaOfActivity = {'activity area': 20}
        libery_indicator = PercentLibraryPerAreaOfActivity(totalLibraryPerAreaOfActivity,20, datetime.now())
        libery_indicator.save()
        querry = PercentLibraryPerAreaOfActivity.objects.first()
        assert querry._totalLibraryPerAreaOfActivity == totalLibraryPerAreaOfActivity
