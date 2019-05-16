CREATE TABLE IF NOT EXISTS users (
 user_id INTEGER PRIMARY KEY,
 username TEXT NOT NULL UNIQUE,
 password TEXT NOT NULL,
 key TEXT UNIQUE
);
CREATE TABLE IF NOT EXISTS groups (
 group_id INTEGER PRIMARY KEY,
 name TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS actions (
 action_id INTEGER PRIMARY KEY,
 verb TEXT NOT NULL,
 url TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS users_groups (
 user_id INTEGER,
 group_id INTEGER,
 PRIMARY KEY (user_id, group_id),
 FOREIGN KEY (user_id) REFERENCES users (user_id)
 ON DELETE CASCADE ON UPDATE NO ACTION,
 FOREIGN KEY (group_id) REFERENCES groups (group_id)
 ON DELETE CASCADE ON UPDATE NO ACTION
);
CREATE TABLE IF NOT EXISTS groups_actions (
 group_id INTEGER,
 action_id INTEGER,
 PRIMARY KEY (group_id, action_id),
 FOREIGN KEY (group_id) REFERENCES groups (group_id)
 ON DELETE CASCADE ON UPDATE NO ACTION
 FOREIGN KEY (action_id) REFERENCES actions (action_id)
 ON DELETE CASCADE ON UPDATE NO ACTION
);

INSERT into users(username, password) values('alan', '$2b$12$4URLa5vJ1XP9Ot9m7a7ZKevIaoTVRj5pLrc9UqS/MTWoNy/aXYPra');
INSERT into users(username, password) values('gabe', '$2b$12$2grDj6Ek88AKUQbPxpe8ke.7YyzsivQ1g1TPrdTAKrfbd3YGt0P3q');
INSERT into groups(name) values('engineers');
INSERT into groups(name) values('managers');
INSERT into actions(verb, url) values('GET', '/apple');
INSERT into actions(verb, url) values('POST', '/banana');
INSERT into actions(verb, url) values('GET', '/kiwi');
INSERT into actions(verb, url) values('POST', '/orange');
INSERT into users_groups(user_id, group_id) values(1, 1);
INSERT into users_groups(user_id, group_id) values(2, 2);
INSERT into groups_actions(group_id, action_id) values(1, 1);
INSERT into groups_actions(group_id, action_id) values(1, 2);
INSERT into groups_actions(group_id, action_id) values(2, 3);
INSERT into groups_actions(group_id, action_id) values(2, 4);

