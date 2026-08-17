import React, { useState, useEffect } from 'react';
import './App.css';
import UserList from './components/UserList';
import UserForm from './components/UserForm';

function App() {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetchUsers();
  }, []);

  const fetchUsers = async () => {
    try {
      setLoading(true);
      const response = await fetch('/api/users');
      if (!response.ok) throw new Error('Failed to fetch users');
      const data = await response.json();
      setUsers(data);
      setError(null);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  const handleUserAdded = () => {
    fetchUsers();
  };

  const handleUserDeleted = (id) => {
    setUsers(users.filter(u => u.id !== id));
  };

  return (
    <div className="app">
      <header className="app-header">
        <h1>Java SQL Application</h1>
        <p>User Management System</p>
      </header>

      <main className="app-main">
        <div className="container">
          <section className="form-section">
            <h2>Add New User</h2>
            <UserForm onUserAdded={handleUserAdded} />
          </section>

          <section className="list-section">
            <h2>Users</h2>
            {loading && <div className="loading">Loading...</div>}
            {error && <div className="error">Error: {error}</div>}
            {!loading && !error && (
              <UserList users={users} onUserDeleted={handleUserDeleted} onRefresh={fetchUsers} />
            )}
          </section>
        </div>
      </main>
    </div>
  );
}

export default App;
