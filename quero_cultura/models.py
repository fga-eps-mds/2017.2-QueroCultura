from mongoengine import *

class PercentTypeEventsForState(Document):
    _typeStateEvents = MapField(required = True)
    _totalStateEvents = MapField(required = True)

    @property
    def typeStateEvents(self):
        return self._typeStateEvents

    @typeStateEvents.setter
    def typeStateEvents(self,number):
        self._typeStateEvents = number

    @property
    def totalStateEvents(self):
        return self._totalStateEvents

    @totalStateEvents.setter
    def totalStateEvents(self,number):
        self._totalStateEvents = number

class PercentEventsForSpace(Document):
    _typeSpaceEvents = MapField(required = True)
    _totalSpaceEvents = MapField(required = True)

        @property
        def typeSpaceEvents(self):
            return self._typeStateEvents

        @typeSpaceEvents.setter
        def typeStateEvents(self,number):
            self._typeStateEvents = number

        @property
        def totalSpaceEvents(self):
            return self._totalStateEvents

        @totalSpaceEvents.setter
        def totalStateEvents(self,number):
            self._totalStateEvents = number

class PercentThematicsMuseumsForState:
    _thematicsMuseumsForState = MapField(required = True)
    _totalMuseumsForState = MapField(requiered = True)

    @property
    def thmeaticsMuseumsForState(self):
        return self._thematicsMuseumsForState

    @thmeaticsMuseumsForState.setter
    def thmeaticsMuseumsForState(self,number):
        self._thematicsMuseumsForState = number

    @property
    def totalMuseumsForState(self):
        return self._totalMuseumsForState

    @totalMuseumsForState.setter
    def totalMuseumsForState(self,number):
        self._totalMuseumsForState = number

class PercentTypeMuseumsForState:
    _typeMuseumsForState = MapField(required = True)
    _totalMuseumsForState = MapField(required = True)

    @property
    def typeMuseumsForState(self):
        return self._typeMuseumsForState

    @typeMuseumsForState.setter
    def typeMuseumsForState(self,number):
        self._typeMuseumsForState = number

    @property
    def totalMuseumsForState(self):
        return self._totalMuseumsForState

    @totalMuseumsForState.setter
    def totalMuseumsForState(self,number):
        self._totalMuseumsForState = number


class PercentPublicOrPrivateMuseums:
    _totalPublicMuseums = IntField(required = True)
    _totalPrivateMuseums = IntField(required = True)
    _totalMuseums = IntField(required = True)


'''
    idPoint = IntField(required = True)
    namePoint = StringField(max_length=100)
    latitudePoint = StringField(max_length=50)
    longitudePoint = StringField(max_length=50)
    shortDescription = StringField()
'''
