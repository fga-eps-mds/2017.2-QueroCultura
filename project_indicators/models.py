# from django.db import models
from mongoengine import Document
from mongoengine import DictField
from mongoengine import IntField
from mongoengine import DateTimeField

# --------------------- national indicators ----------------------------------


class PercentProjectPerType(Document):
    _totalProject = IntField(required=True)
    _totaProjectPerType = DictField(required=True)
    _createDate = DateTimeField(required=True)

    @property
    def total_project(self):
        return self._totalProject

    @total_project.setter
    def total_project(self, number):
        self._totalProject = number

    @property
    def total_project_per_type(self):
        return self._totalProjectPerType

    @total_project_per_type.setter
    def total_project_per_type(self, number):
        self._totalProjectPerType = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number


class PercentProjectThatAcceptOnlineTransitions(Document):
    _totalProjectThatAcceptOnlineTransitions = IntField(required=True)
    _totalProject = IntField(required=True)
    _createDate = DateTimeField(required=True)

    @property
    def total_project(self):
        return self._totalProject

    @total_project.setter
    def total_project(self, number):
        self._totalProject = number

    @property
    def total_project_that_accept_online_transitions(self):
        return self._totalProjectThatAcceptOnlineTransitions

    @total_project_that_accept_online_transitions.setter
    def total_project_that_accept_online_transitions(self, number):
        self._totalProjectThatAcceptOnlineTransitions = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number

# -------------------- state indicators --------------------------------------


class PercentProjectPerTypePerState(Document):
    _totalProjectPerState = DictField(required=True)
    _totaProjectPerTypePerState = DictField(required=True)
    _createDate = DateTimeField(required=True)

    @property
    def total_project_per_state(self):
        return self._totalProjectPerState

    @total_project_per_state.setter
    def total_project_per_state(self, number):
        self._totalProjectPerState = number

    @property
    def total_project_per_type_per_state(self):
        return self._totalProjectPerTypePerState

    @total_project_per_type_per_state.setter
    def total_project_per_type_per_state(self, number):
        self._totalProjectPerTypePerState = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number


class PercentProjectThatAcceptOnlineTransitionsPerState(Document):
    _totalProjectThatAcceptOnlineTransitionsPerState = DictField(required=True)
    _totalProjectPerState = DictField(required=True)
    _createDate = DateTimeField(required=True)

    @property
    def total_project_per_state(self):
        return self._totalProjectPerState

    @total_project_per_state.setter
    def total_project_per_state(self, number):
        self._totalProjecPerStatet = number

    @property
    def total_project_that_accept_online_transitions_per_state(self):
        return self._totalProjectThatAcceptOnlineTransitionsPerState

    @total_project_that_accept_online_transitions_per_state.setter
    def total_project_that_accept_online_transitions_per_state(self, number):
        self._totalProjectThatAcceptOnlineTransitionsPerState = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number

# -------------------- Project Registered -------------------------------------


class QuantityOfRegisteredProject(Document):
    _totalProjectRegisteredPerMounthPerYear = DictField(required=True)
    _totalProjectRegisteredPerYear = DictField(required=True)
    _totalProject = IntField(required=True)
    _createDate = DateTimeField(required=True)

    @property
    def total_project_registered_per_mounth_per_year(self):
        return self._totalProjectRegisteredPerMounthPerYear

    @total_project_registered_per_mounth_per_year.setter
    def total_project_registered_per_mounth_per_year(self, number):
        self._totalProjectRegisteredPerMounthPerYear = number

    @property
    def total_project_registered_per_year(self):
        return self._totalProjectRegisteredPerYear

    @total_project_registered_per_year.setter
    def totalProjectRegisteredPerYear(self, number):
        self._totalProjectRegisteredPerYear = number

    @property
    def total_project(self):
        return self._totalProject

    @total_project.setter
    def total_project(self, number):
        self._totalProject = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number
