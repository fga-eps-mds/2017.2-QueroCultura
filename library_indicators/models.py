from mongoengine import Document
from mongoengine import DictField
from mongoengine import IntField
from mongoengine import DateTimeField

# --------------------- national indicators ----------------------------------



class PercentLibraries(Document):
    class Meta:
        abstract = True

    _total_libraries = IntField(required=True)
    _create_date = DateTimeField(required=True)

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

class PercentLibrariesState(Document):
    class Meta:
        abstract = True
    _libraries_per_state = DictField(required=True)
    _create_date = DateTimeField(required=True)
    @property
    def libraries_per_state(self):
        return self._libraries_per_state

    @libraries_per_state.setter
    def libraries_per_state(self, number):
        self._libraries_per_state = number

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, number):
        self._create_date = number

class PercentLibraryPerAreaOfActivity(PercentLibraries):
    _libraries_per_activity = DictField(required=True)


    @property
    def total_libraries_per_activity(self):
        return self._libraries_per_activity

    @total_libraries_per_activity.setter
    def total_libraries_per_activity(self, number):
        self._libraries_per_activity = number




class PercentPublicOrPrivateLibrary(PercentLibraries):
    _total_public_libraries = IntField(required=True)
    _total_private_libraries = IntField(required=True)


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



# Percentage of libraries by type of sphere
class PercentLibrariesTypeSphere(PercentLibraries):
    _total_libraries_type_sphere = DictField(required=True)

    @property
    def total_libraries_type_sphere(self):
        return self._total_libraries_type_sphere

    @total_libraries_type_sphere.setter
    def total_libraries_type_sphere(self, number):
        self._total_libraries_type_sphere = number


class QuantityOfRegisteredlibraries(PercentLibraries):
    # registered per Month and per Year
    _libraries_registered_monthly = DictField(required=True)
    _libraries_registered_yearly = DictField(required=True)


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



# -------------------- state indicators --------------------------------------

class PercentLibraryForState(PercentLibraries):
    _total_libraries_in_state = DictField(required=True)


    @property
    def total_libraries_in_state(self):
        return self._total_libraries_in_state

    @total_libraries_in_state.setter
    def total_libraries_in_state(self, number):
        self._total_libraries_in_state = number


class PercentLibraryPerAreaOfActivityPerState(PercentLibrariesState):
    _libraries_per_area_per_state = DictField(required=True)


    @property
    def libraries_per_area_per_state(self):
        return self._libraries_per_area_per_state

    @libraries_per_area_per_state.setter
    def libraries_per_area_per_state(self, number):
        self._libraries_per_area_per_state = number




class PercentPublicOrPrivateLibraryPerState(PercentLibrariesState):
    _public_libraries_per_state = DictField(required=True)
    _private_libraries_per_state = DictField(required=True)


    @property
    def public_libraries_per_state(self):
        return self._public_libraries_per_state

    @public_libraries_per_state.setter
    def public_libraries_per_state(self, number):
        self._public_libraries_per_state = number

    @property
    def total_private_library_per_state(self):
        return self._private_libraries_per_state

    @total_private_library_per_state.setter
    def private_libraries_per_state(self, number):
        self._private_libraries_per_state = number



# Percentage of libraries by type of sphere per state
class PercentLibrariesTypeSpherePerState(object):
    _library_type_sphere_per_state = DictField(required=True)
    _create_date = DateTimeField(required=True)

    @property
    def library_type_sphere_per_state(self):
        return self._library_type_sphere_per_state

    @library_type_sphere_per_state.setter
    def library_type_sphere_per_state(self, number):
        self._library_type_sphere_per_state = number

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, number):
        self._create_date = number
