from django.db import models
from mongoengine import *


class PercentLibraryForState(Document):
    _totalLibraryForState = MapField(required=True)
    _totalLibrary = IntField(required=True)

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


class PercentLibraryPerAreaOfActivityPerState(Document):
    _totalLibraryPerAreaOfActivityPerState = MapField(required=True)
    _totalLibraryPerState = MapField(required=True)

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


class PercentLibraryPerAreaOfActivity(Document):
    _totalLibraryPerAreaOfActivity = MapField(required=True)
    _totalLibrary = IntField(required=True)

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


class PercentLibraryPerSpherePerState(Document):
    _totalLibraryPerSpherePerState = MapField(required=True)
    _totalLibraryPerState = MapField(required=True)

    @property
    def totalLibraryPerSpherePerState(self):
        return self._totalLibraryPerSpherePerState

    @totalLibraryPerSpherePerState.setter
    def totalLibraryPerSpherePerState(self, number):
        self._totalLibraryPerSpherePerState = number

    @property
    def totalLibraryPerState(self):
        return self._totalLibrary

    @totalLibraryPerState.setter
    def totalLibraryPerState(self, number):
        self._totalLibraryPerState = number


class PercentLibraryPerSphere(Document):
    _totalLibraryPerSphere = MapField(required=True)
    _totalLibrary = MapField(required=True)

    @property
    def totalLibraryPerSphere(self):
        return self._totalLibraryPerSphere

    @totalLibraryPerSphere.setter
    def totalLibraryPerSphere(self, number):
        self._totalLibraryPerSphere = number

    @property
    def totalLibrary(self):
        return self._totalLibrary

    @totalLibrary.setter
    def totalLibrary(self, number):
        self._totalLibrary = number


class PercentPublicOrPrivateLibrary(Document):
    _totalPublicLibrary = IntField(required=True)
    _totalPrivateLibrary = IntField(required=True)
    _totalLibrary = IntField(required=True)

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


class PercentPublicOrPrivateLibraryPerState(Document):
    _totalPublicLibraryPerState = MapField(required=True)
    _totalPrivateLibraryPerState = MapField(required=True)
    _totalLibraryPerState = MapField(required=True)

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
