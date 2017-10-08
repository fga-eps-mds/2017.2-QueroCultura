# from django.db import models
from mongoengine import Document
from mongoengine import DictField
from mongoengine import IntField
from mongoengine import DateTimeField

# -------------------- state indicators --------------------------------

class PercentMuseumsState(Document):
    class Meta:
        abstract = True
    meta = {'allow_inheritance': True}
    _total_museums_for_state = DictField(required=True)
    _create_date = DateTimeField(required=True)

    @property
    def total_museums_for_state(self):
        return self._total_museums_for_state

    @total_museums_for_state.setter
    def total_museums_for_state(self, number):
        self._total_museums_for_state = number

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, number):
        self._create_date = number

class PercentMuseums(Document):
    class Meta:
        abstract = True
    meta = {'allow_inheritance': True}
    _total_museums = IntField(required=True)
    _create_date = DateTimeField(required=True)

    @property
    def total_museums(self):
        return self._total_museums

    @total_museums.setter
    def total_museums(self, number):
        self._total_museums = number

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, number):
        self._create_date = number

class PercentThematicsMuseumsForState(PercentMuseumsState):
    _thematics_museums_for_state = DictField(required=True)

    @property
    def thmeatics_museums_for_state(self):
        return self._thematics_museums_for_state

    @thmeatics_museums_for_state.setter
    def thmeatics_museums_for_state(self, number):
        self._thematics_museums_for_state = number


class PercentTypeMuseumsForState(PercentMuseumsState):
    _type_museums_for_state = DictField(required=True)

    @property
    def type_museums_for_state(self):
        return self._type_museums_for_state

    @type_museums_for_state.setter
    def type_museums_for_state(self, number):
        self._type_museums_for_state = number



class PercentPublicOrPrivateMuseumsForState(PercentMuseumsState):
    _total_public_museums_for_state = DictField(required=True)
    _total_private_museums_for_state = DictField(required=True)

    @property
    def total_public_museums_for_state(self):
        return self._total_public_museums_for_state

    @total_public_museums_for_state.setter
    def total_public_museums_for_state(self, number):
        self._total_public_museums_for_state = number

    @property
    def total_private_museums_for_state(self):
        return self._total_private_museums_for_state

    @total_private_museums_for_state.setter
    def total_private_museums_for_state(self, number):
        self._total_private_museums_for_state = number


class PercentMuseumsHistoricalArchivePublicAccessForState(PercentMuseumsState):
    _total_historical_archive = \
                                        DictField(required=True)

    @property
    def total_historical_archive(self):
        return self._total_historical_archive

    @total_historical_archive.setter
    def tal_historical_archive(self, number):
        self._total_historical_archive = number


class PercentMuseumsPromoteGuidedTourForState(PercentMuseumsState):
    _total_museums_guide_tour = DictField(required=True)

    @property
    def total_museums_guide_tour(self):
        return self._total_museums_guide_tour

    @total_museums_guide_tour.setter
    def total_museums_guide_tour(self, number):
        self._total_museums_guide_tour = number



# --------------------- national indicators ----------------------------------
class PercentThematicsMuseums(PercentMuseums):
    _thematics_museums = IntField(required=True)

    @property
    def thmeatics_museums(self):
        return self._thematics_museums

    @thmeatics_museums.setter
    def thmeatics_museums(self, number):
        self._thematics_museums = number



class PercentTypeMuseums(PercentMuseums):
    _type_museums = IntField(required=True)

    @property
    def type_museums(self):
        return self._type_museums

    @type_museums.setter
    def type_museums(self, number):
        self._type_museums = number




class PercentPublicOrPrivateMuseums(PercentMuseums):
    _total_public_museums = IntField(required=True)
    _total_private_museums = IntField(required=True)

    @property
    def total_public_museums(self):
        return self._total_public_museums

    @total_public_museums.setter
    def total_public_museums(self, number):
        self._total_public_museums = number

    @property
    def total_private_museums(self):
        return self._total_private_museums

    @total_private_museums.sette
    def total_private_museums(self, number):
        self._total_private_museums = number

class PercentMuseumsHistoricalArchivePublicAccess(PercentMuseums):
    _total_museums_historical = IntField(required=True)

    @property
    def total_museums_historical(self):
        return self._total_museums_historical

    @total_museums_historical.setter
    def total_museums_historical(self, number):
        self._total_museums_historical = number


class PercentMuseumsPromoteGuidedTour(PercentMuseums):
    _total_museums_promote_guide = IntField(required=True)

    @property
    def total_museums_promote_guide(self):
        return self._total_museums_promote_guide

    @total_museums_promote_guide.setter
    def total_museums_promote_guide(self, number):
        self._total_museums_promote_guide = number



# Amount of Museums registered on year on the platform throughout its existence
class AmountMuseumsRegisteredYear(Document):
    _total_museums_registered_year = DictField(required=True)
    _create_date = DateTimeField(required=True)

    @property
    def total_museums_registered_year(self):
        return self._total_museums_registered_year

    @total_museums_registered_year.setter
    def total_museums_registered_year(self, number):
        self._total_museums_registered_year = number

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, number):
        self._create_date = number


# Amount of Museums registered monthly on the platform throughout its existence
class AmountMuseumsRegisteredMonth(Document):
    _total_museums_registered_month = DictField(required=True)
    _create_date = DateTimeField(required=True)

    @property
    def total_museums_registered_month(self):
        return self._total_museums_registered_month

    @total_museums_registered_month.setter
    def total_museums_registered_month(self, number):
        self._total_museums_registered_month = number

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, number):
        self._create_date = number


# Percentage of museumms by states
class PercentMuseumsForState(PercentMuseums):
    _total_museums_for_state = DictField(required=True)

    @property
    def total_museums_for_state(self):
        return self._total_museums_for_state

    @total_museums_for_state.setter
    def total_museums_for_state(self, number):
        self._total_museums_for_state = number
