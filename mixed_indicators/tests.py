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
        mixed_indicator = PercentEventsInAccessibleSpaces(indicator, {"df": 50}, datetime.now())
        mixed_indicator.save()
        querry = PercentEventsInAccessibleSpaces.objects.first()
        assert querry._totalEvents == indicator

    def test_total_events_in_acessible_(self):
        PercentEventsInAccessibleSpaces.drop_collection()
        indicator = {"espaço": 50}
        mixed_indicator = PercentEventsInAccessibleSpaces(50 , indicator, datetime.now())
        mixed_indicator.save()
        querry = PercentEventsInAccessibleSpaces.objects.first()
        assert querry._totalEventsInAccessibleSpaces == indicator


class TestPercentEventsInMoreThenOneSpace(object):

    def test_total_events(self):
        PercentEventsInMoreThenOneSpace.drop_collection()
        indicator = 50
        mixed_indicator = PercentEventsInMoreThenOneSpace(indicator, {"evento": "espaço"}, datetime.now())
        mixed_indicator.save()
        querry = PercentEventsInMoreThenOneSpace.objects.first()
        assert querry._totalEvents == indicator

    def test_total_events_in_more_then_one_space(self):
        PercentEventsInMoreThenOneSpace.drop_collection()
        indicator = {"evento": "espaço"}
        mixed_indicator = PercentEventsInMoreThenOneSpace(50, indicator, datetime.now())
        mixed_indicator.save()
        querry = PercentEventsInMoreThenOneSpace.objects.first()
        assert querry._totalEventsInMoreThenOneSpace == indicator


class TestPercentEventsInMoreThenOneSpacePerState(object):

    def test_total_events_per_state(self):
        PercentEventsInMoreThenOneSpacePerState.drop_collection()
        indicator = {"df": 50}
        mixed_indicator = PercentEventsInMoreThenOneSpacePerState(indicator, {"evento": "espaço"}, datetime.now())
        mixed_indicator.save()
        querry = PercentEventsInMoreThenOneSpacePerState.objects.first()
        assert querry._totalEventsPerState == indicator

    def test_total_events_in_more_then_one_space_per_state(self):
        PercentEventsInMoreThenOneSpacePerState.drop_collection()
        indicator = {"evento": "espaço"}
        mixed_indicator = PercentEventsInMoreThenOneSpacePerState({"df": 50}, indicator, datetime.now())
        mixed_indicator.save()
        querry = PercentEventsInMoreThenOneSpacePerState.objects.first()
        assert querry._totalEventsInMoreThenOneSpacePerState == indicator


class TestPercentEventsInAccessibleSpacesPerState(object):

    def test_total_events_per_state(self):
        PercentEventsInAccessibleSpacesPerState.drop_collection()
        indicator = {"df": 50}
        mixed_indicator = PercentEventsInAccessibleSpacesPerState(indicator, {"espaço": 50}, datetime.now())
        mixed_indicator.save()
        querry = PercentEventsInAccessibleSpacesPerState.objects.first()
        assert querry._totalEventsPerState == indicator

    def test_total_events_in_acessible_per_state(self):
        PercentEventsInAccessibleSpacesPerState.drop_collection()
        indicator = {"espaço": 50}
        mixed_indicator = PercentEventsInAccessibleSpacesPerState({"df": 50} , indicator, datetime.now())
        mixed_indicator.save()
        querry = PercentEventsInAccessibleSpacesPerState.objects.first()
        assert querry._totalEventsInAccessibleSpacesPerState == indicator


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
