from mongoengine import Document
from mongoengine import IntField
from mongoengine import DateTimeField

class PercentProjects(Document):
    class Meta:
        abstract = True
    meta = {'allow_inheritance': True}
    _total_project = IntField(required=True)
    _create_date = DateTimeField(required=True)
    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, number):
        self._create_date = number

    @property
    def total_project(self):
        return self._total_project

    @total_project.setter
    def total_project(self, number):
        self._total_project = number

class PercentProjectPerType(PercentProjects):

    _total_project_per_type = IntField(required=True)

    @property
    def total_project_per_type(self):
        return self._total_project_per_type

    @total_project_per_type.setter
    def total_project_per_type(self, number):
        self._total_project_per_type = number


class PercentProjectThatAcceptOnlineTransitions(PercentProjects):
    _total_project_that_accept_online_transitions = IntField(required=True)

    @property
    def total_project_that_accept_online_transitions(self):
        return self._total_project_that_accept_online_transitions

    @total_project_that_accept_online_transitions.setter
    def total_project_that_accept_online_transitions(self, number):
        self._total_project_that_accept_online_transitions = number


class PercentProjectPerTypePerState(Document):
    _total_project_per_state = IntField(required=True)
    _total_project_per_type_per_state = IntField(required=True)
    _create_date = DateTimeField(required=True)

    @property
    def total_project_per_state(self):
        return self._total_project_per_state

    @total_project_per_state.setter
    def total_project_per_state(self, number):
        self._total_project_per_state = number

    @property
    def total_project_per_type_per_state(self):
        return self._total_project_per_type_per_state

    @total_project_per_type_per_state.setter
    def total_project_per_type_per_state(self, number):
        self._total_project_per_type_per_state = number

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, number):
        self._create_date = number


class PercentProjectThatAcceptOnlineTransitionsPerState(Document):
    _total_project_online_transitions = IntField(required=True)
    _total_project_per_state = IntField(required=True)
    _create_date = DateTimeField(required=True)

    @property
    def total_project_per_state(self):
        return self._total_project_per_state

    @total_project_per_state.setter
    def total_project_per_state(self, number):
        self._total_project_per_state = number

    @property
    def total_project_that_accept_online_transitions_per_state(self):
        return self._total_project_online_transitions

    @total_project_that_accept_online_transitions_per_state.setter
    def total_project_that_accept_online_transitions_per_state(self, number):
        self.__total_project_online_transitions = number

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, number):
        self._create_date = number


class QuantityOfRegisteredProject(PercentProjects):
    _total_project_registered_per_mounth_per_year = IntField(required=True)
    _total_project_registered_per_year = IntField(required=True)

    @property
    def total_project_registered_per_mounth_per_year(self):
        return self._total_project_registered_per_mounth_per_year

    @total_project_registered_per_mounth_per_year.setter
    def total_project_registered_per_mounth_per_year(self, number):
        self._total_project_registered_per_mounth_per_year = number

    @property
    def total_project_registered_per_year(self):
        return self._total_project_registered_per_year

    @total_project_registered_per_year.setter
    def totalProjectRegisteredPerYear(self, number):
        self._total_project_registered_per_year = number
