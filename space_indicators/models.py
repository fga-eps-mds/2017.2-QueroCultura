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

class PercentSpaceState(Document):
    class Meta:
        abstract = True
    _total_space_per_state = DictField(required=True)
    _create_date = DateTimeField(required=True)

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, number):
        self._create_date = number
    @property
    def total_space_per_state(self):
        return self._total_space_per_state

    @total_space_per_state.setter
    def total_space_per_state(self, number):
        self._total_space_per_state = number

class PercentSpacePerType(PercentSpace):
    _total_space_per_type = DictField(required=True)


    @property
    def total_space_per_type(self):
        return self._total_space_per_type

    @total_space_per_type.setter
    def total_space_per_type(self, number):
        self._total_space_per_type = number




class PercentSpacePerOccupationArea(PercentSpace):
    _total_Space = DictField(required=True)


    @property
    def total_space_per_occupation_area(self):
        return self._total_Space

    @total_space_per_occupation_area.setter
    def total_space_per_occupation_area(self, number):
        self._total_Space = number


# -------------------- state indicators --------------------------------------


class PercentSpacePerTypePerState(PercentSpaceState):
    _total_space = DictField(required=True)

    @property
    def total_space(self):
        return self._total_space

    @total_space.setter
    def total_space(self, number):
        self._total_space = number


class PercentSpacePerOccupationAreaPerState(PercentSpaceState):
    _total_space_occupation_area_per_state = DictField(required=True)

    @property
    def total_space_occupation_area_per_state(self):
        return self._total_space_occupation_area_per_state

    @total_space_occupation_area_per_state.setter
    def total_space_occupation_area_per_state(self, number):
        self._total_space_occupation_area_per_state = number


class PercentSpaceForState(PercentSpaceState):
    _total_spaces = IntField(required=True)

    @property
    def total_spaces(self):
        return self._total_spaces

    @total_spaces.setter
    def total_spaces(self, number):
        self._total_spaces = number


# -------------------- Space Registered --------------------------------------


class QuantityOfRegisteredSpace(PercentSpace):
    _total_space_registered_per_mounth_per_year = DictField(required=True)
    _total_space_register = DictField(required=True)

    @property
    def total_space_registered_per_mounth_per_year(self):
        return self._total_space_registered_per_mounth_per_year

    @total_space_registered_per_mounth_per_year.setter
    def total_space_registered_per_mounth_per_year(self, number):
        self._total_space_registered_per_mounth_per_year = number

    @property
    def total_space_register(self):
        return self._total_space_register

    @total_space_registered_per_year.setter
    def ttotal_space_register(self, number):
        self._total_space_register = number
