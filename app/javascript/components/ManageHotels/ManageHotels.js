import React, { useState, useEffect } from 'react'
import axios from 'axios'
import MaterialTable from 'material-table'
import { ThemeProvider, createTheme } from '@mui/material';
import { forwardRef } from 'react';
import AddBox from '@material-ui/icons/AddBox';
import ArrowDownward from '@material-ui/icons/ArrowDownward';
import Check from '@material-ui/icons/Check';
import ChevronLeft from '@material-ui/icons/ChevronLeft';
import ChevronRight from '@material-ui/icons/ChevronRight';
import Clear from '@material-ui/icons/Clear';
import DeleteOutline from '@material-ui/icons/DeleteOutline';
import Edit from '@material-ui/icons/Edit';
import FilterList from '@material-ui/icons/FilterList';
import FirstPage from '@material-ui/icons/FirstPage';
import LastPage from '@material-ui/icons/LastPage';
import Remove from '@material-ui/icons/Remove';
import SaveAlt from '@material-ui/icons/SaveAlt';
import Search from '@material-ui/icons/Search';
import ViewColumn from '@material-ui/icons/ViewColumn';

const tableIcons = {
  Add: forwardRef((props, ref) => <AddBox {...props} ref={ref} />),
  Check: forwardRef((props, ref) => <Check {...props} ref={ref} />),
  Clear: forwardRef((props, ref) => <Clear {...props} ref={ref} />),
  Delete: forwardRef((props, ref) => <DeleteOutline {...props} ref={ref} />),
  DetailPanel: forwardRef((props, ref) => <ChevronRight {...props} ref={ref} />),
  Edit: forwardRef((props, ref) => <Edit {...props} ref={ref} />),
  Export: forwardRef((props, ref) => <SaveAlt {...props} ref={ref} />),
  Filter: forwardRef((props, ref) => <FilterList {...props} ref={ref} />),
  FirstPage: forwardRef((props, ref) => <FirstPage {...props} ref={ref} />),
  LastPage: forwardRef((props, ref) => <LastPage {...props} ref={ref} />),
  NextPage: forwardRef((props, ref) => <ChevronRight {...props} ref={ref} />),
  PreviousPage: forwardRef((props, ref) => <ChevronLeft {...props} ref={ref} />),
  ResetSearch: forwardRef((props, ref) => <Clear {...props} ref={ref} />),
  Search: forwardRef((props, ref) => <Search {...props} ref={ref} />),
  SortArrow: forwardRef((props, ref) => <ArrowDownward {...props} ref={ref} />),
  ThirdStateCheck: forwardRef((props, ref) => <Remove {...props} ref={ref} />),
  ViewColumn: forwardRef((props, ref) => <ViewColumn {...props} ref={ref} />)
};

const theme = createTheme()

const token = document.querySelector('meta[name="csrf-token"]').content;

const ManageHotels = () => {
  const [data, setData] = useState([]);
  const [isError, setIsError] = useState(false)
  const [errorMessages, setErrorMessages] = useState([])

  useEffect(() => {
    fetch("/admin/hotels")
      .then(response => response.json())
      .then(data => setData(data))
      .catch(error => {
        setErrorMessages(["Cannot load user data"])
        setIsError(true)
      })
  }, [])


  const handleRowAdd = (newData, resolve) => {
    let errorList = []
    if (newData.name === undefined) { errorList.push("Please enter a name") }
    if (newData.phone === undefined) { errorList.push("Please enter a phone number") }
    if (newData.street_address === undefined) { errorList.push("Please enter a street address") }
    if (newData.city === undefined) { errorList.push("Please enter a city") }
    if (newData.zip === undefined) { errorList.push("Please enter a zip code") }

    if (errorList.length < 1) {
      fetch("/admin/hotels", {
        method: 'POST',
        headers: {
          "X-CSRF-Token": token,
          "Content-Type": "application/json"
        },
        body: JSON.stringify(newData)
      })
        .then(res => res.json())
        .then(res => {
          let dataToAdd = [...data];
          dataToAdd.push(newData);
          setData(dataToAdd);
          resolve()
          setErrorMessages([])
          setIsError(false)
        })
        .catch(error => {
          console.log('error caught!')
          console.log(error)
          console.error(error)
          setErrorMessages(["Cannot add data. Server error!"])
          setIsError(true)
          resolve()
        })
    } else {
      setErrorMessages(errorList)
      setIsError(true)
      resolve()
    }
  }

  const handleRowUpdate = (newData, oldData, resolve) => {
    let errorList = []
    if (newData.name === undefined) { errorList.push("Please enter a name") }
    if (newData.phone === undefined) { errorList.push("Please enter a phone number") }
    if (newData.address === undefined) { errorList.push("Please enter a name") }
    // if (newData.street_address === undefined) { errorList.push("Please enter a street address") }
    // if (newData.city === undefined) { errorList.push("Please enter a city") }
    // if (newData.zip === undefined) { errorList.push("Please enter a zip code") }

    console.log(newData)

    if (errorList.length < 1) {
      // slim down the object payload
      // remove unnecessary properties
      // deleted_at, created_at, updated_at
      fetch(`${newData.id}`, {
        method: 'PUT',
        headers: {
          "X-CSRF-Token": token,
          "Content-Type": "application/json"
        },
        body: JSON.stringify(newData)
      })
        .then(res => {
          const dataUpdate = [...data];
          const index = oldData.tableData.id;
          dataUpdate[index] = newData;
          setData([...dataUpdate]);
          resolve()
          setIsError(false)
          setErrorMessages([])
        })
        .catch(error => {
          setErrorMessages(["Update failed! Server error"])
          setIsError(true)
          resolve()
        })
    } else {
      setErrorMessages(errorList)
      setIsError(true)
      resolve()
    }
  }

  let columns = [
    { title: "Id", field: "id", type: 'numeric', hidden: true },
    { title: "Name", field: "name" },
    { title: "Phone", field: "phone" },
    { title: "Street Address", field: "street_address", render: data => data.address.street || '-' },
    { title: "City", field: "city", render: data => data.address.city || '-' },
    { title: "Zip", field: "zip", render: data => data.address.zip || '-' },
    { title: "Active", field: "active", type: 'boolean', editable: 'onUpdate' },
  ]

  return (
    <ThemeProvider theme={theme}>
      {isError && JSON.stringify(errorMessages)}
      <MaterialTable
        icons={tableIcons}
        title="Manage Hotels"
        columns={columns}
        data={data}
        editable={{
          onRowAdd: (newData) =>
            new Promise((resolve) => {
              handleRowAdd(newData, resolve)
            }),
          onRowUpdate: (newData) =>
            new Promise((resolve) => {
              handleRowUpdate(newData, resolve)
            })
        }}
      />
    </ThemeProvider>
  )
};

export default ManageHotels