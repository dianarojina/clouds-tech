import pytest
from app import app as app

@pytest.fixture
def webapp():
    app.config['TESTING'] = True
    yield app

@pytest.fixture()
def client(webapp):
    return webapp.test_client()

def test_index_page(client):
    res = client.get('/')
    assert res.status_code == 200
    assert 'Hello, World' in res.text
