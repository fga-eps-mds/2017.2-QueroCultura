from datetime import datetime
from .api_connections import RequestMixedIndicatorsRawData
from .models import PercentEventsInAccessibleSpaces
from .models import PercentEventsInMoreThenOneSpace
from .models import PercentEventsInMoreThenOneSpacePerState
from .models import PercentEventsInAccessibleSpacesPerState


class TestPercentEventsInAccessibleSpaces(object):

    def test_total_events(self):
        PercentEventsInAccessibleSpaces.drop_collection()
        indicator = 50
        mixed_indicator = PercentEventsInAccessibleSpaces(indicator, 50, datetime.now())
        mixed_indicator.save()
        query = PercentEventsInAccessibleSpaces.objects.first()
        assert query._totalEvents == indicator

    def test_total_events_in_acessible_(self):
        PercentEventsInAccessibleSpaces.drop_collection()
        indicator = 50
        mixed_indicator = PercentEventsInAccessibleSpaces(50 , indicator, datetime.now())
        mixed_indicator.save()
        query = PercentEventsInAccessibleSpaces.objects.first()
        assert query._totalEventsInAccessibleSpaces == indicator


class TestPercentEventsInMoreThenOneSpace(object):

    def test_total_events(self):
        PercentEventsInMoreThenOneSpace.drop_collection()
        indicator = 50
        mixed_indicator = PercentEventsInMoreThenOneSpace(indicator, 10, datetime.now())
        mixed_indicator.save()
        query = PercentEventsInMoreThenOneSpace.objects.first()
        assert query._totalEvents == indicator

    def test_total_events_in_more_then_one_space(self):
        PercentEventsInMoreThenOneSpace.drop_collection()
        indicator = 10
        mixed_indicator = PercentEventsInMoreThenOneSpace(50, 10, datetime.now())
        mixed_indicator.save()
        query = PercentEventsInMoreThenOneSpace.objects.first()
        assert query._totalEventsInMoreThenOneSpace == indicator


class TestPercentEventsInMoreThenOneSpacePerState(object):

    def test_total_events_per_state(self):
        PercentEventsInMoreThenOneSpacePerState.drop_collection()
        indicator = 10
        mixed_indicator = PercentEventsInMoreThenOneSpacePerState(indicator, 10, datetime.now())
        mixed_indicator.save()
        query = PercentEventsInMoreThenOneSpacePerState.objects.first()
        assert querry._totalEventsPerState == indicator

    def test_total_events_in_more_then_one_space_per_state(self):
        PercentEventsInMoreThenOneSpacePerState.drop_collection()
        indicator = 10
        mixed_indicator = PercentEventsInMoreThenOneSpacePerState(10, indicator, datetime.now())
        mixed_indicator.save()
        query = PercentEventsInMoreThenOneSpacePerState.objects.first()
        assert query._totalEventsInMoreThenOneSpacePerState == indicator


class TestPercentEventsInAccessibleSpacesPerState(object):

    def test_total_events_per_state(self):
        PercentEventsInAccessibleSpacesPerState.drop_collection()
        indicator = 10
        mixed_indicator = PercentEventsInAccessibleSpacesPerState(indicator, 10, datetime.now())
        mixed_indicator.save()
        query = PercentEventsInAccessibleSpacesPerState.objects.first()
        assert query._totalEventsPerState == indicator

    def test_total_events_in_acessible_per_state(self):
        PercentEventsInAccessibleSpacesPerState.drop_collection()
        indicator = 25
        mixed_indicator = PercentEventsInAccessibleSpacesPerState(25 , indicator, datetime.now())
        mixed_indicator.save()
        query = PercentEventsInAccessibleSpacesPerState.objects.first()
        assert query._totalEventsInAccessibleSpacesPerState == indicator


class TestClassRequestMixedRawData(object):

    def test_success_request(self):
        current_time = datetime.now().__str__()
        request_mixed_raw_data = RequestMixedIndicatorsRawData(current_time)
        response_mixed_raw_data = request_mixed_raw_data.response
        response_status_code = response_mixed_raw_data.status_code
        assert response_status_code == 200

    def test_data_content(self):
        current_time = datetime.now().__str__()
        request_mixed_raw_data = RequestMixedIndicatorsRawData(current_time)
        mixed_raw_data = request_mixed_raw_data.data
        type_mixed_raw_data = type(mixed_raw_data)
        empty_list = []
        assert type_mixed_raw_data == type(empty_list)

    def test_data_lenght(self):
        current_time = datetime.now().__str__()
        request_mixed_raw_data = RequestMixedIndicatorsRawData(current_time)
        mixed_raw_data = request_mixed_raw_data.data_length
        type_mixed_raw_data = type(mixed_raw_data)
        intenger = 1
        assert type_mixed_raw_data == type(intenger)
