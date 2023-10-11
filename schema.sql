create table exchange_days {
	id INTEGER PRIMARY KEY,
	name text NOT NULL,
	swish_number text NOT NULL
};

create table sellers {
	id INTEGER PRIMARY KEY,
	name text NOT NULL,
	seller_number INTEGER NOT NULL,
	swish_number text NOT NULL,
	exchange_day_id INTEGER,
	FOREIGN KEY (exchange_day_id) REFERENCES exchange_days(id)
};

create table orders {
	id INTEGER PRIMARY KEY,
	exchange_day_id INTEGER,
	FOREIGN KEY (exchange_day_id) REFERENCES exchange_days(id)
};


create table order_rows {
	id INTEGER PRIMARY KEY,
	seller_id INTEGER,
	order_id INTEGER,
	FOREIGN KEY (seller_id) REFERENCES sellers(id),
	FOREIGN KEY (order_id) REFERENCES orders(id)
};
