CREATE TABLE IF NOT EXISTS users (
 user_id INTEGER PRIMARY KEY,
 username TEXT NOT NULL,
 password TEXT NOT NULL,
 key TEXT
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
