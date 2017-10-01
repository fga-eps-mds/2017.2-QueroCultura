# from django.db import models
from mongoengine import Document
from mongoengine import DictField
from mongoengine import IntField
from mongoengine import DateTimeField

# --------------------- national indicators ----------------------------------


class PercentLibraryPerAreaOfActivity(Document):
    _libraries_per_activity = DictField(required=True)
    _total_libraries = IntField(required=True)
    _create_date = DateTimeField(required=True)

    @property
    def total_libraries_per_activity(self):
        return self._libraries_per_activity

    @total_libraries_per_activity.setter
    def total_libraries_per_activity(self, number):
        self._libraries_per_activity = number

    @property
    def total_libraries(self):
        return self._total_libraries

    @total_libraries.setter
    def total_libraries(self, number):
        self._total_libraries = number

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, number):
        self._create_date = number


class PercentPublicOrPrivateLibrary(Document):
    _total_public_libraries = IntField(required=True)
    _total_private_libraries = IntField(required=True)
    _total_libraries = IntField(required=True)
    _create_date = DateTimeField(required=True)

    @property
    def total_public_libraries(self):
        return self._total_public_libraries

    @total_public_libraries.setter
    def total_public_library(self, number):
        self._total_public_libraries = number

    @property
    def total_private_libraries(self):
        return self._total_private_libraries

    @total_private_libraries.setter
    def total_private_library(self, number):
        self._total_private_libraries = number

    @property
    def total_libraries(self):
        return self._total_libraries

    @total_libraries.setter
    def total_library(self, number):
        self._total_libraries = number

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, number):
        self._create_date = number


# Percentage of libraries by type of sphere
class PercentLibrariesTypeSphere(object):
    _total_libraries_type_sphere = DictField(required=True)
    _total_libraries = IntField(required=True)
    _create_date = DateTimeField(required=True)

    @property
    def total_libraries_type_sphere(self):
        return self._total_libraries_type_sphere

    @total_libraries_type_sphere.setter
    def total_libraries_type_sphere(self, number):
        self._total_libraries_type_sphere = number

    @property
    def total_library(self):
        return self._total_libraries

    @total_library.setter
    def total_library(self, number):
        self._total_libraries = number

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, number):
        self._create_date = number


class QuantityOfRegisteredlibraries(Document):
    # registered per Month and per Year
    _libraries_registered_monthly = DictField(required=True)
    _libraries_registered_yearly = DictField(required=True)
    _total_libraries = IntField(required=True)
    _create_date = DateTimeField(required=True)

    @property
    def libraries_registered_monthly(self):
        return self._libraries_registered_monthly

    @libraries_registered_monthly.setter
    def libraries_registered_monthly(self, number):
        self._libraries_registered_monthly = number

    @property
    def libraries_registered_yearly(self):
        return self._libraries_registered_yearly

    @libraries_registered_yearly.setter
    def libraries_registered_yearly(self, number):
        self._libraries_registered_yearly = number

    @property
    def total_libraries(self):
        return self._total_libraries

    @total_libraries.setter
    def total_library(self, number):
        self._total_libraries = number

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, number):
        self._create_date = number


# -------------------- state indicators --------------------------------------

class PercentLibraryForState(Document):
    _totalLibraryForState = DictField(required=True)
    _totalLibrary = IntField(required=True)
    _createDate = DateTimeField(required=True)

    @property
    def total_library_for_state(self):
        return self._totalLibraryForState

    @total_library_for_state.setter
    def total_library_for_state(self, number):
        self._totalLibraryForState = number

    @property
    def total_library(self):
        return self._totalLibrary

    @total_library.setter
    def total_library(self, number):
        self._totalLibrary = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number


class PercentLibraryPerAreaOfActivityPerState(Document):
    _totalLibraryPerAreaOfActivityPerState = DictField(required=True)
    _totalLibraryPerState = DictField(required=True)
    _createDate = DateTimeField(required=True)

    @property
    def total_library_per_area_of_activity_per_state(self):
        return self._totalLibraryPerAreaOfActivityPerState

    @total_library_per_area_of_activity_per_state.setter
    def total_library_per_area_of_activity_per_state(self, number):
        self._totalLibraryPerAreaOfActivityPerState = number

    @property
    def total_library_per_state(self):
        return self._totalLibraryPerState

    @total_library_per_state.setter
    def total_library_per_state(self, number):
        self._totalLibraryPerState = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number


class PercentPublicOrPrivateLibraryPerState(Document):
    _totalPublicLibraryPerState = DictField(required=True)
    _totalPrivateLibraryPerState = DictField(required=True)
    _totalLibraryPerState = DictField(required=True)
    _createDate = DateTimeField(required=True)

    @property
    def total_public_library_per_state(self):
        return self._totalPublicLibraryPerState

    @total_public_library_per_state.setter
    def total_public_library_per_state(self, number):
        self._totalPublicLibraryPerState = number

    @property
    def total_private_library_per_state(self):
        return self._totalPrivateLibraryPerState

    @total_private_library_per_state.setter
    def totalPrivateLibraryPerState(self, number):
        self._totalPrivateLibraryPerState = number

    @property
    def total_library_per_state(self):
        return self._totalLibraryPerState

    @total_library_per_state.setter
    def total_library_per_state(self, number):
        self._totalLibraryPerState = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number


# Percentage of libraries by type of sphere per state
class PercentLibrariesTypeSpherePerState(object):
    _totalLibrariesTypeSpherePerState = DictField(required=True)
    _createDate = DateTimeField(required=True)

    @property
    def total_libraries_type_sphere_per_state(self):
        return self._totalLibrariesTypeSpherePerState

    @total_libraries_type_sphere_per_state.setter
    def total_libraries_type_sphere_per_state(self, number):
        self._totalLibrariesTypeSpherePerState = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number
