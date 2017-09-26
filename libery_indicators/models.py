# from django.db import models
from mongoengine import Document
from mongoengine import MapField
from mongoengine import IntField
from mongoengine import StringField

# --------------------- national indicators ----------------------------------


class PercentLibraryPerAreaOfActivity(Document):
    _totalLibraryPerAreaOfActivity = MapField(required=True)
    _totalLibrary = IntField(required=True)
    _createDate = StringField(required=True)

    @property
    def total_library_per_area_of_activity(self):
        return self._totalLibraryPerAreaOfActivity

    @total_library_per_area_of_activity.setter
    def total_library_per_area_of_activity(self, number):
        self._totalLibraryPerAreaOfActivity = number

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


class PercentPublicOrPrivateLibrary(Document):
    _totalPublicLibrary = IntField(required=True)
    _totalPrivateLibrary = IntField(required=True)
    _totalLibrary = IntField(required=True)
    _createDate = StringField(required=True)

    @property
    def total_public_library(self):
        return self._totalPublicLibrary

    @total_public_library.setter
    def total_public_library(self, number):
        self._totalPublicLibrary = number

    @property
    def total_private_library(self):
        return self._totalPrivateLibrary

    @total_private_library.setter
    def total_private_library(self, number):
        self._totalPrivateLibrary = number

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


# Percentage of libraries by type of sphere
class PercentLibrariesTypeSphere:
    _totalLibrariesTypeSphere = MapField(required=True)
    _createDate = StringField(required=True)

    @property
    def _total_libraries_type_sphere(self):
        return self._totalLibrariesTypeSphere

    @_total_libraries_type_sphere.setter
    def _total_libraries_type_sphere(self, number):
        self._totalLibrariesTypeSphere = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number


class QuantityOfRegisteredLibrarys(Document):
    _totalLibrarysRegisteredPerMounthPerYear = MapField(required=True)
    _totalLibrarysRegisteredPerYear = MapField(required=True)
    _totalLibrarys = IntField(required=True)
    _createDate = StringField(required=True)

    @property
    def total_librarys_registered_per_mounth_per_year(self):
        return self._totalLibrarysRegisteredPerMounthPerYear

    @total_librarys_registered_per_mounth_per_year.setter
    def total_librarys_registered_per_mounth_per_year(self, number):
        self._totalLibrarysRegisteredPerMounthPerYear = number

    @property
    def total_librarys_registered_per_year(self):
        return self._totalLibrarysRegisteredPerYear

    @total_librarys_registered_per_year.setter
    def total_librarys_registered_per_year(self, number):
        self._totalLibrarysRegisteredPerYear = number

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


# -------------------- state indicators --------------------------------------

class PercentLibraryForState(Document):
    _totalLibraryForState = MapField(required=True)
    _totalLibrary = IntField(required=True)
    _createDate = StringField(required=True)

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
    _totalLibraryPerAreaOfActivityPerState = MapField(required=True)
    _totalLibraryPerState = MapField(required=True)
    _createDate = StringField(required=True)

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
    _totalPublicLibraryPerState = MapField(required=True)
    _totalPrivateLibraryPerState = MapField(required=True)
    _totalLibraryPerState = MapField(required=True)
    _createDate = StringField(required=True)

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
class PercentLibrariesTypeSpherePerState:
    _totalLibrariesTypeSpherePerState = MapField(required=True)
    _createDate = StringField(required=True)

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
