const { server } = require('../server.js')
const request = require('supertest')

describe('Testing route', () => {
  it('Route /', async done => {
    await request(server)
      .get('/')
      .expect(200)
    done()
  })
})

afterAll(() => {
  server.close()
})

jest.setTimeout(10000)
