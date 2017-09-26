# from django.db import models
from mongoengine import Document
from mongoengine import MapField
from mongoengine import IntField
from mongoengine import StringField

# --------------------- national indicators ----------------------------------


class PercentSpacePerType(Document):
    _totalSpace = IntField(required=True)
    _totalSpacePerType = MapField(required=True)
    _createDate = StringField(required=True)

    @property
    def total_space(self):
        return self._totalSpace

    @total_space.setter
    def total_space(self, number):
        self._totalSpace = number

    @property
    def total_space_per_type(self):
        return self._totalSpacePerType

    @total_space_per_type.setter
    def total_space_per_type(self, number):
        self._totalSpacePerType = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number


class PercentSpacePerOccupationArea(Document):
    _totalSpacePerOccupationArea = MapField(required=True)
    _totalSpace = IntField(required=True)
    _createDate = StringField(required=True)

    @property
    def total_space(self):
        return self._totalSpace

    @total_space.setter
    def total_space(self, number):
        self._totalSpace = number

    @property
    def total_space_per_occupation_area(self):
        return self._totalSpacePerOccupationArea

    @total_space_per_occupation_area.setter
    def total_space_per_occupation_area(self, number):
        self._totalSpacePerOccupationArea = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number

# -------------------- state indicators --------------------------------------


class PercentSpacePerTypePerState(Document):
    _totalSpacePerState = MapField(required=True)
    _totaSpacePerTypePerState = MapField(required=True)
    _createDate = StringField(required=True)

    @property
    def total_space_per_state(self):
        return self._totalSpacePerState

    @total_space_per_state.setter
    def total_space_per_state(self, number):
        self._totalSpacPerStatee = number

    @property
    def total_space_per_type_per_state(self):
        return self._totalSpacePerTypePerState

    @total_space_per_type_per_state.setter
    def total_space_per_type_per_state(self, number):
        self._totalSpacePerTypePerState = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number


class PercentSpacePerOccupationAreaPerState(Document):
    _totalSpacePerOccupationAreaPerState = MapField(required=True)
    _totalSpacePerState = MapField(required=True)
    _createDate = StringField(required=True)

    @property
    def total_space_per_state(self):
        return self._totalSpacePerState

    @total_space_per_state.setter
    def total_space_per_state(self, number):
        self._totalSpacePerState = number

    @property
    def total_space_per_occupation_area_per_state(self):
        return self._totalSpacePerOccupationAreaPerState

    @total_space_per_occupation_area_per_state.setter
    def total_space_per_occupation_area_per_state(self, number):
        self._totalSpacePerOccupationArea = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number


class PercentSpaceForState(Document):
    _totalSpaces = IntField(required=True)
    _totalSpacePerState = MapField(required=True)
    _createDate = StringField(required=True)

    @property
    def total_spaces(self):
        return self._totalSpaces

    @total_spaces.setter
    def total_spaces(self, number):
        self._totalSpaces = number

    @property
    def total_space_per_state(self):
        return self._totalSpacePerState

    @total_space_per_state.setter
    def total_space_per_state(self, number):
        self._totalSpacePerState = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number


# -------------------- Space Registered --------------------------------------


class QuantityOfRegisteredSpace(Document):
    _totalSpaceRegisteredPerMounthPerYear = MapField(required=True)
    _totalSpaceRegisteredPerYear = MapField(required=True)
    _totalSpace = IntField(required=True)
    _createDate = StringField(required=True)

    @property
    def total_space_registered_per_mounth_per_year(self):
        return self._totalSpaceRegisteredPerMounthPerYear

    @total_space_registered_per_mounth_per_year.setter
    def total_space_registered_per_mounth_per_year(self, number):
        self._totalSpaceRegisteredPerMounthPerYear = number

    @property
    def total_space_registered_per_year(self):
        return self._totalSpaceRegisteredPerYear

    @total_space_registered_per_year.setter
    def total_space_registered_per_year(self, number):
        self._totalSpaceRegisteredPerYear = number

    @property
    def total_space(self):
        return self._totalSpace

    @total_space.setter
    def total_space(self, number):
        self._totalSpace = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number
