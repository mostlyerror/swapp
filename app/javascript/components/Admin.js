import React, { useState, useEffect } from 'react'
import axios from 'axios'
import PropTypes from 'prop-types'

// import { DataGrid } from '@mui/x-data-grid';

const Admin = props => {
    const [hotels, setHotels] = useState([])

    useEffect(() => {
        const hotelsUrl = `/admin/hotels/manage.json`
        axios.get(hotelsUrl).then(res => setHotels(res.data))

    }, [])
    return (
        <ul>
            <h2>Admin</h2>
            {JSON.stringify(hotels)}
            {hotels.map(hotel => (
                <li key={hotel.id}>{hotel.id}</li>
            ))}
        </ul>
    )
}

Admin.defaultProps = {
    name: 'Ben'
}

Admin.propTypes = {
    name: PropTypes.string
}

export default Admin
