from sqlalchemy import (
    Column,
    Index,
    Integer,
    Text,
)

import hashlib

from .meta import Base

add_safety = hashlib.sha512('encrypting'.encode('utf-8')).hexdigest()


class User(Base):
    __tablename__ = 'user'
    id = Column(Integer, primary_key=True)
    login = Column(Text, default="", nullable=False)
    email = Column(Text, default="", nullable=False)
    password = Column(Text, default="", nullable=False)

    def set_password(self, new_password):
        self.password = hashlib.sha512((add_safety + new_password).encode("utf-8")).hexdigest()

    def check_password(self, password):
        return self.password == hashlib.sha512((add_safety + password).encode("utf-8")).hexdigest()

