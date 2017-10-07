# from django.db import models
from mongoengine import Document
from mongoengine import DictField
from mongoengine import IntField
from mongoengine import DateTimeField

# --------------------- national indicators ----------------------------------

class PercentSpace(Document):
    class Meta:
        abstract = True
    _total_space = IntField(required=True)
    _create_date = DateTimeField(required=True)

    @property
    def total_space(self):
        return self._total_space

    @total_space.setter
    def total_space(self, number):
        self._total_space = number
    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, number):
        self._create_date = number

class PercentSpacePerType(Document):
    _totalSpacePerType = DictField(required=True)


    @property
    def total_space_per_type(self):
        return self._totalSpacePerType

    @total_space_per_type.setter
    def total_space_per_type(self, number):
        self._totalSpacePerType = number




class PercentSpacePerOccupationArea(Document):
    _totalSpacePerOccupationArea = DictField(required=True)
    _totalSpace = IntField(required=True)
    _createDate = DateTimeField(required=True)

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
    _totalSpacePerState = DictField(required=True)
    _totaSpacePerTypePerState = DictField(required=True)
    _createDate = DateTimeField(required=True)

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
    _totalSpacePerOccupationAreaPerState = DictField(required=True)
    _totalSpacePerState = DictField(required=True)
    _createDate = DateTimeField(required=True)

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
    _totalSpacePerState = DictField(required=True)
    _createDate = DateTimeField(required=True)

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
    _totalSpaceRegisteredPerMounthPerYear = DictField(required=True)
    _totalSpaceRegisteredPerYear = DictField(required=True)
    _totalSpace = IntField(required=True)
    _createDate = DateTimeField(required=True)

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
