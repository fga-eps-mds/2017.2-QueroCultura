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
    def totalLibraryPerAreaOfActivity(self):
        return self._totalLibraryPerAreaOfActivity

    @totalLibraryPerAreaOfActivity.setter
    def totalLibraryPerAreaOfActivity(self, number):
        self._totalLibraryPerAreaOfActivity = number

    @property
    def totalLibrary(self):
        return self._totalLibrary

    @totalLibrary.setter
    def totalLibrary(self, number):
        self._totalLibrary = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number


class PercentPublicOrPrivateLibrary(Document):
    _totalPublicLibrary = IntField(required=True)
    _totalPrivateLibrary = IntField(required=True)
    _totalLibrary = IntField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalPublicLibrary(self):
        return self._totalPublicLibrary

    @totalPublicLibrary.setter
    def totalPublicLibrary(self, number):
        self._totalPublicLibrary = number

    @property
    def totalPrivateLibrary(self):
        return self._totalPrivateLibrary

    @totalPrivateLibrary.setter
    def totalPrivateLibrary(self, number):
        self._totalPrivateLibrary = number

    @property
    def totalLibrary(self):
        return self._totalLibrary

    @totalLibrary.setter
    def totalLibrary(self, number):
        self._totalLibrary = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number


# Percentage of libraries by type of sphere
class PercentLibrariesTypeSphere:
    _totalLibrariesTypeSphere = MapField(required=True)
    _createDate = StringField(required=True)

    @property
    def _totalLibrariesTypeSphere(self):
        return self._totalLibrariesTypeSphere

    @_totalLibrariesTypeSphere.setter
    def _totalLibrariesTypeSphere(self, number):
        self._totalLibrariesTypeSphere = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number


class QuantityOfRegisteredLibrarys(Document):
    _totalLibrarysRegisteredPerMounthPerYear = MapField(required=True)
    _totalLibrarysRegisteredPerYear = MapField(required=True)
    _totalLibrarys = IntField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalLibrarysRegisteredPerMounthPerYear(self):
        return self._totalLibrarysRegisteredPerMounthPerYear

    @totalLibrarysRegisteredPerMounthPerYear.setter
    def totalLibrarysRegisteredPerMounthPerYear(self, number):
        self._totalLibrarysRegisteredPerMounthPerYear = number

    @property
    def totalLibrarysRegisteredPerYear(self):
        return self._totalLibrarysRegisteredPerYear

    @totalLibrarysRegisteredPerYear.setter
    def totalLibrarysRegisteredPerYear(self, number):
        self._totalLibrarysRegisteredPerYear = number

    @property
    def totalLibrary(self):
        return self._totalLibrary

    @totalLibrary.setter
    def totalLibrary(self, number):
        self._totalLibrary = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number


# -------------------- state indicators --------------------------------------

class PercentLibraryForState(Document):
    _totalLibraryForState = MapField(required=True)
    _totalLibrary = IntField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalLibraryForState(self):
        return self._totalLibraryForState

    @totalLibraryForState.setter
    def totalLibraryForState(self, number):
        self._totalLibraryForState = number

    @property
    def totalLibrary(self):
        return self._totalLibrary

    @totalLibrary.setter
    def totalLibrary(self, number):
        self._totalLibrary = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number


class PercentLibraryPerAreaOfActivityPerState(Document):
    _totalLibraryPerAreaOfActivityPerState = MapField(required=True)
    _totalLibraryPerState = MapField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalLibraryPerAreaOfActivityPerState(self):
        return self._totalLibraryPerAreaOfActivityPerState

    @totalLibraryPerAreaOfActivityPerState.setter
    def totalLibraryPerAreaOfActivityPerState(self, number):
        self._totalLibraryPerAreaOfActivityPerState = number

    @property
    def totalLibraryPerState(self):
        return self._totalLibraryPerState

    @totalLibraryPerState.setter
    def totalLibraryPerState(self, number):
        self._totalLibraryPerState = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number


class PercentPublicOrPrivateLibraryPerState(Document):
    _totalPublicLibraryPerState = MapField(required=True)
    _totalPrivateLibraryPerState = MapField(required=True)
    _totalLibraryPerState = MapField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalPublicLibraryPerState(self):
        return self._totalPublicLibraryPerState

    @totalPublicLibraryPerState.setter
    def totalPublicLibraryPerState(self, number):
        self._totalPublicLibraryPerState = number

    @property
    def totalPrivateLibraryPerState(self):
        return self._totalPrivateLibraryPerState

    @totalPrivateLibraryPerState.setter
    def totalPrivateLibraryPerState(self, number):
        self._totalPrivateLibraryPerState = number

    @property
    def totalLibraryPerState(self):
        return self._totalLibraryPerState

    @totalLibraryPerState.setter
    def totalLibraryPerState(self, number):
        self._totalLibraryPerState = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number


# Percentage of libraries by type of sphere per state
class PercentLibrariesTypeSpherePerState:
    _totalLibrariesTypeSpherePerState = MapField(required=True)
    _createDate = StringField(required=True)

    @property
    def _totalLibrariesTypeSpherePerState(self):
        return self._totalLibrariesTypeSpherePerState

    @_totalLibrariesTypeSpherePerState.setter
    def _totalLibrariesTypeSpherePerState(self, number):
        self._totalLibrariesTypeSpherePerState = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number
