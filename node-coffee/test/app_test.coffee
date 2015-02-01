should = require 'should'
request = require 'supertest'
app = require '../app'

port = 4000
localhost = 'http://localhost:' + port



describe 'app', () ->
  before () ->
    app.listen port

  after (done) ->
    request(localhost)
    .delete('/developers')
    .expect 200, done

  it 'should exists', (done) ->
    should.exist app
    done()

  it 'root should return 200', (done) ->
    request(localhost)
    .get('/')
    .expect(200)
    .expect("Hello, every SB!", done)

  it 'create a developer should return id', (done) ->

    testDev = {
      name : 'test'
      desc : 'testDev'
      gender : 'male'
    }

    request(localhost)
    .post('/developers')
    .set('Content-Type', 'application/json')
    .send(testDev)
    .expect(200)
    .expect (res) ->
      should.exist res.body._id
    .end(done);

  it 'create a developer should return all the fields', (done) ->
    testDev = {
      name : 'test'
      desc : 'testDev'
      gender : 'male'
    }

    request(localhost)
    .post('/developers')
    .set('Content-Type', 'application/json')
    .send(testDev)
    .expect(200)
    .expect (res) ->
      should.exist res.body._id
      should.equal(testDev.name, res.body.name)
      should.equal testDev.desc, res.body.desc
      should.equal testDev.gender, res.body.gender
    .end(done);

  it 'create a developer with non json content type should return 400', (done) ->
    request(localhost)
    .post('/developers')
    .set('Content-Type', 'ramdom-type')
    .send('random text')
    .expect(415)
    .end(done);


