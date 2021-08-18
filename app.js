const express = require('express');
const app = express();
const mysql = require('mysql');
const bodyParser = require('body-parser');
const multer = require('multer');
const upload = multer();
const { 
  v1: uuidv1,
  v4: uuidv4,
} = require('uuid');

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
    extended: true
}));

// for parsing multipart/form-data
app.use(upload.array()); 
app.use(express.static('public'));

// connection configurations
const mc = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'testnode',
    multipleStatements: true,
});

// connect to database
mc.connect();
 
// default route
app.get('/', function (req, res) {
    return res.send({ error: true, message: 'cannot go inside this one' })
});

// Retrieve all event datas 
app.get('/events', function (req, res) {
	//console.log(uuidv4());
    mc.query('SELECT e.* FROM event e', function (error, results, fields) {
        if (error) throw error;
        return res.send({ error: false, data: results, message: 'Events all list.' });
    });
});

// Retrieve all location datas 
app.get('/locations', function (req, res) {
    mc.query('SELECT * FROM location', function (error, results, fields) {
        if (error) throw error;
        return res.send({ error: false, data: results, message: 'Locations list.' });
    });
});
 
// Retrieve all ticket datas 
app.get('/tickets', function (req, res) {
    mc.query('SELECT tic.id as ticket_id,tic.name,tic.price,tic.name as ticket_name,e.name as event_name,loc.name as location,e.date as event_date FROM ticket tic LEFT JOIN event e ON tic.event_id = e.id LEFT JOIN location loc ON e.location_id = loc.id', function (error, results, fields) {
        if (error) throw error;
        return res.send({ error: false, data: results, message: 'Tickets list.' });
    });
});

 
 
// Retrieve event data with id 
app.get('/event/get_info/:id', function (req, res) {
 
    let tax_id = req.params.id;
 
    mc.query('SELECT e.id,e.name as event_name,e.date,loc.name as location FROM event e LEFT JOIN location loc ON e.location_id = loc.id where e.id=?', tax_id, function (error, results, fields) {
        if (error) throw error;
        return res.send({ error: false, data: results[0], message: 'Event info.' });
    });
 
});
 
// Add a new location

app.post('/location/create', function (req, res) {
    
    let name = req.body.name;
	let uuid = uuidv4();
    
    //console.log(task);
    if (!name) {
        return res.status(400).send({ error:true, message: 'Please provide location' });
    }
 
    mc.query("INSERT INTO location SET ? ", { name: name, uuid: uuid }, function (error, results, fields) {
        if (error) throw error;

        var response = [{ "name" : name, "uuid" : uuid }];
        //return res.send({ error: false, data: response });
        mc.query('SELECT * FROM location', function (error, results, fields) {
            if (error) throw error;
            console.log(response);
            return res.send({ error: false, data: response });
        });
    });
});

// Add a new event

app.post('/event/create', function (req, res) {
    
    let name = req.body.name;
    let loc = req.body.loc;
	let date = req.body.date;
	let uuid = uuidv4();

    if (!name) {
        return res.status(400).send({ error:true, message: 'Please provide event' });
    }
	
	if (!loc) {
        return res.status(400).send({ error:true, message: 'Please provide location' });
    }
	
	if (!date) {
        return res.status(400).send({ error:true, message: 'Please provide date' });
    }
	
    mc.query("INSERT INTO event SET ? ", { name: name, location_id: loc, date: date, uuid: uuid }, function (error, results, fields) {
        if (error) throw error;

        var response = [{ "name" : name, "location" : loc, "date" : date, "uuid" : uuid }];
        //return res.send({ error: false, data: response });
        mc.query('SELECT e.* FROM event e', function (error, results, fields) {
            if (error) throw error;
            console.log(response);
            return res.send({ error: false, data: response });
        });
    });
});

// Add a new ticket

app.post('/event/ticket/create', function (req, res) {
    
    let name = req.body.name;
    let ev = req.body.ev;
	let price = req.body.price;
	let quota = req.body.quota;
	let uuid = uuidv4();
	
    if (!name) {
        return res.status(400).send({ error:true, message: 'Please provide ticket' });
    }
	
	if (!ev) {
        return res.status(400).send({ error:true, message: 'Please provide event' });
    }
	
	if (!price) {
        return res.status(400).send({ error:true, message: 'Please provide price' });
    }
	
	if (!quota) {
        return res.status(400).send({ error:true, message: 'Please provide quota' });
    }
 
    mc.query("INSERT INTO ticket SET ? ", { name: name, event_id: ev, price: price, quota: quota, uuid: uuid }, function (error, results, fields) {
        if (error) throw error;

        var response = [{ "name" : name, "event" : ev, "price" : price, "quota" : quota, "uuid" : uuid}];
        //return res.send({ error: false, data: response });
        mc.query('SELECT tic.id as ticket_id,tic.uuid as ticket_uuid,tic.name,tic.price,tic.name as ticket_name,e.name as event_name,loc.name as location,e.date as event_date FROM ticket tic LEFT JOIN event e ON tic.event_id = e.id LEFT JOIN location loc ON e.location_id = loc.id', function (error, results, fields) {
            if (error) throw error;
            console.log(response);
            return res.send({ error: false, data: response });
        });
    });
});


// Purchase ticket

app.post('/transaction/purchase', function (req, res) {
    
    let ticket_id = req.body.ticket;
    let customer = req.body.customer;
	let date = req.body.date;
	let uuid = uuidv4();
	
    if (!ticket_id) {
        return res.status(400).send({ error:true, message: 'Please provide ticket' });
    }
	
	if (!customer) {
        return res.status(400).send({ error:true, message: 'Please provide customer' });
    }
	
	if (!date) {
        return res.status(400).send({ error:true, message: 'Please provide date' });
    }
	
	mc.query('SELECT * FROM ticket where id=?', ticket_id, function (error, results, fields) {
        if (error) throw error;
        let quota = results[0]['quota'];
		let newquota = quota-1;
		
		mc.query("INSERT INTO transaction SET ? ", { ticket_id : ticket_id, customer_id: customer, trans_date: date, uuid: uuid }, function (error, results, fields) {
			if (error) throw error;

			var response = [{ "ticket_id" : ticket_id, "customer_id" : customer, "trans_date" : date, "uuid" : uuid}];
			//return res.send({ error: false, data: response });
			
			mc.query("UPDATE ticket SET quota="+ newquota +" WHERE id = ? ", ticket_id, function (error, results, fields) {
				if (error) throw error;
			});	
			
			mc.query('SELECT tic.id as ticket_id,tic.uuid as ticket_uuid,tic.name,tic.price,tic.name as ticket_name,e.name as event_name,loc.name as location,e.date as event_date FROM ticket tic LEFT JOIN event e ON tic.event_id = e.id LEFT JOIN location loc ON e.location_id = loc.id', function (error, results, fields) {
				if (error) throw error;
				console.log(response);
				return res.send({ error: false, data: response });
			});
		});
		
    });
 
});
 
// all other requests redirect to 404
app.all("*", function (req, res, next) {
    return res.send('page not found');
    next();
});
 
// port must be set to 8080 because incoming http requests are routed from port 80 to port 8080
app.listen(8080, function () {
    console.log('Node app is running on port 8080');
});
 
// allows "grunt dev" to create a development server with livereload
module.exports = app;