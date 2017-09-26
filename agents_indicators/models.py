# from django.db import models
from mongoengine import Document
from mongoengine import MapField
from mongoengine import IntField
from mongoengine import StringField


# Percentage of individual and collective agents
class PercentIndividualAndCollectiveAgent(Document):
    _totalIndividualAgent = IntField(required=True)
    _totalCollectiveAgent = IntField(required=True)
    _totalAgents = IntField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalIndividualAgent(self):
        return self._totalIndividualAgent

    @totalIndividualAgent.setter
    def totalIndividualAgent(self, number):
        self._totalIndividualAgent = number

    @property
    def totalCollectiveAgent(self):
        return self._totalCollectiveAgent

    @totalCollectiveAgent.setter
    def totalCollectiveAgent(self, number):
        self._totalCollectiveAgent = number

    @property
    def totalAgents(self):
        return self._totalAgents

    @totalAgents.setter
    def totalAgents(self, number):
        self._totalAgents = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number


# Amount of agents registered per year on the platform throughout its existence
class AmountAgentsRegisteredPerYear(Document):
    _totalAgentsRegisteredPerYear = MapField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalAgentsRegisteredPerYear(self):
        return self._totalAgentsRegisteredPerYear

    @totalAgentsRegisteredPerYear.setter
    def totalAgentsRegisteredPerYear(self, number):
        self._totalAgentsRegisteredPerYear = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number


# Number of agents registered monthly on the platform throughout its existence
class AmountAgentsRegisteredPerMonth(Document):
    _totalAgentsRegisteredPerMonth = MapField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalAgentsRegisteredPerMonth(self):
        return self._totalAgentsRegisteredPerMonth

    @totalAgentsRegisteredPerMonth.setter
    def totalAgentsRegisteredPerMonth(self, number):
        self._totalAgentsRegisteredPerMonth = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number


class PercentAgentsPerAreaOperation(Document):
    _totalAgentsPerAreaOreration = MapField(required=True)
    _totalAgents = IntField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalAgentsPerAreaOreration(self):
        return self._totalAgentsPerAreaOreration

    @totalAgentsPerAreaOreration.setter
    def totalAgentsPerAreaOreration(self, number):
        self._totalAgentsPerAreaOreration = number

    @property
    def totalAgents(self):
        return self._totalAgents

    @totalAgents.setter
    def totalAgents(self, number):
        self._totalAgents = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number


# -------------------- state indicators --------------------------------
class PercentAgentsForState(Document):
    _totalAgentsForStates = MapField(required=True)
    _totalAgents = IntField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalAgentsForStates(self):
        return self._totalAgentsForStates

    @totalAgentsForStates.setter
    def totalAgentsForStates(self, number):
        self._totalAgentsForStates = number

    @property
    def totalAgents(self):
        return self._totalAgents

    @totalAgents.setter
    def totalAgents(self, number):
        self._totalAgents = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number


class PercentAgentsPerAreaOperationForState(Document):
    _totalAgentsPerAreaOrerationForState = MapField(required=True)
    _totalAgentsForState = MapField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalAgentsPerAreaOrerationForState(self):
        return self._totalAgentsPerAreaOrerationForState

    @totalAgentsPerAreaOrerationForState.setter
    def totalAgentsPerAreaOrerationForState(self, number):
        self._totalAgentsPerAreaOrerationForState = number

    @property
    def totalAgentsForState(self):
        return self._totalAgentsForState

    @totalAgentsForState.setter
    def totalAgentsForState(self, number):
        self._totalAgentsForState = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number


class PercentIndividualAndCollectiveAgentForState(Document):
    _totalIndividualAgentForState = MapField(required=True)
    _totalCollectiveAgentForState = MapField(required=True)
    _totalAgentsForState = MapField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalIndividualAgentForState(self):
        return self._totalIndividualAgentForState

    @totalIndividualAgentForState.setter
    def totalIndividualAgentForState(self, number):
        self._totalIndividualAgentForState = number

    @property
    def totalCollectiveAgentForState(self):
        return self._totalCollectiveAgentForState

    @totalCollectiveAgentForState.setter
    def totalCollectiveAgentForState(self, number):
        self._totalCollectiveAgentForState = number

    @property
    def totalAgentsForState(self):
        return self._totalAgentsForState

    @totalAgentsForState.setter
    def totalAgentsForState(self, number):
        self._totalAgentsForState = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number
